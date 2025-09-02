// String Constants

import SwiftUI
import Foundation

// MARK: - Strings
public enum Str {
    /// Hello 
    public static let helloKey = LocalizedString(table: "Localizable", lookupKey: "hello_key")

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

