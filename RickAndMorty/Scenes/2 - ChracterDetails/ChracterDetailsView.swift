//
//  ChracterDetailsView.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 04/09/2025.
//  Copyright © 2025 Link Development. All rights reserved.
//


import SwiftUI
import ComposableArchitecture
import BMSwiftUI
import Kingfisher

struct ChracterDetailsView: View {
    @Bindable var store: StoreOf<ChracterDetailsFeature>
    
    var body: some View {
        WithViewState(
            viewState: $store.viewState,
            isRefreshable: true
        ) {
            Unwrap(store.characterDetails) { details in
                ScrollView {
                    VStack(spacing: -30){
                        headerView(details: details)
                        contentView(details: details)
                    }
                }
                .background(Color.white)
            }
        } retryAction: {
            store.send(.fetchCharacter)
        }
        .task {
            store.send(.fetchCharacter)
        }
        .navigationBarBackButtonHidden(true)
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea()
        
    }
    
    private func headerView(details: CharacterListItem) -> some View {
        ZStack(alignment: .topLeading) {
            KFImage(details.image.toURL)
                .placeholder{
                    Image.ChrachterPlaceHolder
                        .resizable()
                        .frame(height: Helpers.screenSize.height * 0.7)
                        .aspectRatio(contentMode: .fill)
                }
                .resizable()
                .loadDiskFileSynchronously()
                .cacheMemoryOnly()
                .fade(duration: 0.25)
                .frame(height: Helpers.screenSize.height * 0.7)
                .aspectRatio(contentMode: .fill)
            
            Button {
                store.send(.didPressOnBackButton)
            } label: {
                Image(systemName: "chevron.backward")
                    .resizable()
                    .setFrame(width: 15, height: 20)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.appMainColor)
                    
            }
            .setFrame(width: 50, height: 50)
            .background {
                Capsule()
                    .foregroundStyle(Color.white)
            }
            .setPadding(20)
            .setPadding(.top, 30)
        }
    }
    
    private func contentView(details: CharacterListItem) -> some View {
        Group {
            VStack(alignment: .leading, spacing: 20) {
                HStack {
                    Spacer()
                    
                    Text(details.name)
                        .textStyle(fontWeight: .bold, size: 25, color: .appTextColor)
                        .multilineTextAlignment(.center)
                    Spacer()
                }
                
                Text(Str.status(p1: details.status.localizedString))
                Text(Str.species(p1: details.species))
                
            }
            .textStyle(fontWeight: .regular, size: 20, color: .appTextColor)
            .setPadding(25)
        }
        .background(.white)
        .setCornerRadius(40)
    }
}

#Preview{
    NavigationStack {
        ChracterDetailsView(
            store: .init(
                initialState: ChracterDetailsFeature.State(characterId: 1),
                reducer: {
                    ChracterDetailsFeature()
                }
            )
        )
    }
}
