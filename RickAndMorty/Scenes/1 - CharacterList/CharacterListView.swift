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
import LoaderUI
import Kingfisher

struct CharacterListView: View {
    @Bindable var store: StoreOf<CharacterListFeature>
    
    var body: some View {
        NavigationStack {
            WithViewState(
                viewState: $store.viewState,
                isRefreshable: true
            ) {
                List {
                    ForEach(store.characterListItems, id: \.id) { chracter in
                        cellForCharacter(chracter)
                            .listRowSeparator(.hidden)
                            .listRowBackground(Color.clear)
                    }
                    
                    footerView
                        .listRowSeparator(.hidden)
                        .listRowBackground(Color.clear)
                }
                .background(Color.appMainBackground)
                .listStyle(.plain)
                .searchable(text: $store.searchText)
                .setPadding(.top, 20)
            } retryAction: {
                store.send(.fetchCharacterList(at: .first))
            }
            .onFirstAppear {
                store.send(.fetchCharacterList(at: .first))
            }
            .navigationTitle(Str.characters.key)
            .navigationBarTitleDisplayMode(.large)
            .navigation(
                item: $store.scope(
                    state: \.characterDetailsState,
                    action: \.characterDetailsAction
                )
            ) {
                ChracterDetailsView(store: $0)
            }
        }
    }
    
    private func cellForCharacter(
        _ character: CharacterListItem
    ) -> some View {
        Button {
            store.send(.didSelectCharacter(character))
        } label: {
            ZStack(alignment:.bottomLeading) {
                KFImage(character.image.toURL)
                    .placeholder{
                        Image.ChrachterPlaceHolder
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .setFrame(height: 300)
                            .setCornerRadius(10, corners: [.topLeft, .topRight])
                    }
                    .resizable()
                    .loadDiskFileSynchronously()
                    .cacheMemoryOnly()
                    .fade(duration: 0.25)
                    .aspectRatio(contentMode: .fill)
                    .setFrame(height: 300)
                    .setCornerRadius(10, corners: .allCorners)
                
                VStack(alignment: .leading) {
                    Text(Str.name(p1: character.name))
                    Text(Str.species(p1: character.species))
                }
                .textStyle(fontWeight: .medium, size: 13, color: .appTextColor)
                .setPadding(10)
                .background {
                    Color.white.opacity(0.9)
                        .setCornerRadius(20, corners: [.topRight, .bottomRight])
                }
                .setPadding(.bottom, 20)
            }
            .background {
                Color.white
                    .setCornerRadius(10)
                    .shadow(radius: 4)
            }
        }
    }
    
    private var footerView: some View {
        HStack {
            Spacer()
            
            BallPulseSync()
                .frame(width: 50, height: 50, alignment: .center)
                .foregroundColor(.appMainColor)
                .taskDelayed(1) {
                    store.send(.fetchCharacterList(at: .next))
                }
            
            Spacer()
        }
        .isHidden(!store.shouldPaginate, remove: true)
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
