//
//  AppFont.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 03/09/2025.
//

import SwiftUI
import BMSwiftUI

public enum FontWeight: String {
    case black = "Black"
    case bold = "Bold"
    case extraBold = "ExtraBold"
    case extraLight = "ExtraLight"
    case light = "Light"
    case medium = "Medium"
    case regular = "Regular"
    case semiBold = "SemiBold"
}


struct TextStyleModifier: ViewModifier {
    let fontWeight: FontWeight
    let size: CGFloat
    let color: Color
    
    init(fontWeight: FontWeight, size: CGFloat, color: Color) {
        self.size = size
        self.fontWeight = fontWeight
        self.color = color
    }
    
    func body(content: Content) -> some View {
        content
            .font(.custom("Cairo \(fontWeight.rawValue)", size: size))
            .foregroundStyle(color)
    }
}


public extension View {
    func textStyle(
        fontWeight: FontWeight = .regular,
        size: CGFloat = 16,
        color: Color = .black
    ) -> some View {
        let scalingFactor = DeviceHelper.getScalingFactor()
        let modified = self.modifier(
            TextStyleModifier(
                fontWeight: fontWeight,
                size: size * scalingFactor,
                color: color
            )
        )
        
        return modified.dynamicTypeSize(.small ... .xxxLarge)
    }
}

