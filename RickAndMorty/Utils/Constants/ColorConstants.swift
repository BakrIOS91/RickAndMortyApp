//
//  ColorConstants.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 03/09/2025.
//

import SwiftUI
import BMSwiftUI

extension Color {
    var uiColor: UIColor { UIColor(self) }
    static let appTextColor       = Color(light: "#1C1917", dark: "#1C1917")
    static let appMainColor       = Color(light: "#162456", dark: "#162456")
    static let appMainBackground  = Color(light: "#F5F5F4", dark: "#F5F5F4")
    static let appDarkGray        = Color(light: "#292524", dark: "#292524")
    static let appLightGray       = Color(light: "#D6D3D1", dark: "#D6D3D1")
}
