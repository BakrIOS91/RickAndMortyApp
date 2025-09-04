#!/bin/bash
echo "🚧 Generating Localized String Constants..."

ROOT_DIR="${SRCROOT}/RickAndMorty"
XCSTRINGS_PATH="${ROOT_DIR}/Resources/Localizable.xcstrings"
OUTPUT_PATH="${ROOT_DIR}/Utils/Constants/StringConstants.swift"

entries=$(jq -r '.strings | to_entries[] | "\(.key)|\(.value.localizations["en"].stringUnit.value // "")"' "$XCSTRINGS_PATH")

output="// String Constants

import SwiftUI
import Foundation

// MARK: - Strings
public enum Str {
"

interpolationFunctions=""

while IFS='|' read -r key value; do
    [[ -z "$key" || -z "$value" ]] && continue

    docComment=$(echo "$value" | tr '\n' ' ')

    varName=$(echo "$key" | \
        sed -E 's/[^a-zA-Z0-9]+/ /g' | \
        awk '{ for (i=1; i<=NF; i++) {
            $i = (i == 1 ? tolower($i) : toupper(substr($i,1,1)) substr($i,2))
        }; print }' | sed 's/ //g')

    if grep -qE '%([0-9]+\$)?(@|ld|lld|lf|llf|\\.[0-9]+f)' <<< "$value"; then
        formatArgs=()
        argNames=()
        i=1

        matches=$(grep -oE '%([0-9]+\$)?(@|ld|lld|lf|llf|\\.[0-9]+f)' <<< "$value" | grep -v '^%%$')

        while read -r token; do
            [[ -z "$token" ]] && continue
            clean="${token//%/}"
            clean="${clean//[0-9]\$*/}"

            argLabel="p$i"
            case "$clean" in
                "@" )
                    formatArgs+=("$argLabel: String")
                    argNames+=("$argLabel") ;;
                "ld" )
                    formatArgs+=("$argLabel: Int")
                    argNames+=("$argLabel") ;;
                "lld" )
                    formatArgs+=("$argLabel: Int64")
                    argNames+=("$argLabel") ;;
                "lf" | "llf" )
                    formatArgs+=("$argLabel: Double")
                    argNames+=("$argLabel") ;;
                *f )
                    formatArgs+=("$argLabel: Double")
                    argNames+=("$argLabel") ;;
                * )
                    formatArgs+=("$argLabel: String")
                    argNames+=("$argLabel") ;;
            esac
            ((i++))
        done <<< "$matches"

        argList=$(IFS=, ; echo "${formatArgs[*]}")
        argValues=$(IFS=, ; echo "${argNames[*]}")

        interpolationFunctions+="
    /// $docComment
    public static func $varName($argList) -> LocalizedStringKey {
        let format = NSLocalizedString(\"$key\", bundle: .main, comment: \"\")
        return String(format: format, $argValues).localizedStringKey
    }"
    else
        output+="    /// $docComment
    public static let $varName = LocalizedString(table: \"Localizable\", lookupKey: \"$key\")\n"
    fi

done <<< "$entries"

output+="$interpolationFunctions
}

// MARK: - Implementation Details

public struct LocalizedString: Hashable, Sendable {
    let table: String
    fileprivate let lookupKey: String
    let bundle: Bundle = .main

    public init(table: String, lookupKey: String) {
        self.table = table
        self.lookupKey = lookupKey
    }

    public var key: LocalizedStringKey {
        self.text.localizedStringKey
    }

    public var text: String {
        String(
            localized: String.LocalizationValue(lookupKey),
            table: table,
            bundle: bundle,
            locale: Locale.current,
            comment: nil
        )
    }

    public var textView: Text {
        Text(LocalizedStringKey(lookupKey), tableName: table, bundle: bundle)
    }
}

// MARK: - Convenience extensions

public extension LocalizedStringKey {
    var textView: Text {
        Text(self)
    }
}

public extension String {
    var localizedStringKey: LocalizedStringKey {
        LocalizedStringKey(self)
    }
}
"

# Save to output path
echo -e "$output" > "$OUTPUT_PATH"

echo "✅ Generated SwiftGen-style localized enum in $OUTPUT_PATH"
