//
//  CharacterListView.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 03/09/2025.
//  Copyright © 2025 Link Development. All rights reserved.
//


import SwiftUI
import ComposableArchitecture
import BMSwiftUI

struct CharacterListView: View {
    @Bindable var store: StoreOf<CharacterListFeature>
    
    var body: some View {
        EmptyView()
    }
}

#Preview {
    CharacterListView(
        store: .init(
            initialState: CharacterListFeature.State(),
            reducer: {
                CharacterListFeature()
            }
        )
    )
}
