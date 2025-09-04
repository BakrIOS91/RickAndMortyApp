//
//  Helpers.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 04/09/2025.
//

import Foundation
import UIKit
import SwiftUI

struct Helpers {
    static var screenSize: CGSize {
        return UIScreen.main.bounds.size
    }
    
    static func wait(_ duration: Double = 2, perform: @escaping () -> Void ) {
        DispatchQueue.main.asyncAfter(deadline: .now() + duration, execute: perform)
    }
    
    static func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = Color.appMainColor.uiColor

        // Large title font + color
        let largeTitle = FontHelper.font(size: 34, weight: .bold, color: .white)

        // Inline title font + color
        let title = FontHelper.font(size: 17, weight: .semiBold, color: .white)

        // Large title
        appearance.largeTitleTextAttributes = [
            .foregroundColor: largeTitle.color,
            .font: largeTitle.font
        ]

        // Inline title
        appearance.titleTextAttributes = [
            .foregroundColor: title.color,
            .font: title.font
        ]

        // Apply nav bar appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance

        // Scroll edge (slightly translucent so search bar shows)
        let scrollEdgeAppearance = appearance.copy()
        scrollEdgeAppearance.configureWithTransparentBackground()
        scrollEdgeAppearance.backgroundColor = Color.appMainColor.uiColor.withAlphaComponent(0.9)
        UINavigationBar.appearance().scrollEdgeAppearance = scrollEdgeAppearance

        // Buttons (back, bar items)
        UINavigationBar.appearance().tintColor = .white

        // 🔹 Style SwiftUI .searchable (UISearchBar)
        // Light style (white field, dark text/icons)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).backgroundColor = UIColor.white.withAlphaComponent(0.9)
        UITextField.appearance(whenContainedInInstancesOf: [UISearchBar.self]).textColor = .black
        UISearchBar.appearance().tintColor = .black
    }
}


