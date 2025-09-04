//
//  ErrorView.swift
//  RickAndMorty
//
//  Created by Bakr Mohamed on 03/09/2025.
//

import SwiftUI
import BMSwiftUI

struct ErrorView: View {
    // MARK: - Property Wrappers
    @Binding var viewState: ViewState
    
    // MARK: - Properties
    let image: Image
    let title: LocalizedStringKey
    let message: LocalizedStringKey?
    let buttonText: LocalizedStringKey?
    let buttonAction: (() -> Void)?

    // MARK: - Initializer
    init(
        viewState: Binding<ViewState> = .constant(.loaded),
        image: Image,
        title: LocalizedStringKey,
        message: LocalizedStringKey? = nil,
        buttonText: LocalizedStringKey? = nil,
        buttonAction: (() -> Void)? = nil
    ) {
        self.image = image
        self.title = title
        self.message = message
        self.buttonText = buttonText
        self._viewState = viewState
        self.buttonAction = buttonAction
    }
    
    // MARK: - Body
    var body: some View {
        ZStack {
            Color.appMainBackground.ignoresSafeArea()
            
            VStack(spacing: 16) {
                headerSection
                messageSection
                buttonSection
            }
            .padding()
        }
    }
}

// MARK: - Micro Views
private extension ErrorView {
    /// Displays the error image and title
    var headerSection: some View {
        VStack(spacing: -30) {
            image
                .resizable()
                .scaledToFit()
                .setFrame(width: 250, height: 250)
            
            Text(title)
                .textStyle(fontWeight: .bold, size: 16)
                .multilineTextAlignment(.center)
        }
    }
    
    /// Shows the optional error message
    @ViewBuilder
    var messageSection: some View {
        if let message = message {
            Text(message)
                .textStyle(
                    fontWeight: .regular,
                    size: 14,
                    color: .appTextColor
                )
                .setPadding(.horizontal, 16)
                .multilineTextAlignment(.center)
        }
    }
    
    /// Shows retry or action button if provided
    @ViewBuilder
    var buttonSection: some View {
        if let buttonText = buttonText, let buttonAction = buttonAction {
            Button {
                // Update state to show loading before triggering the action
                viewState = .overlayLoading(.appMainBackground)
                buttonAction()
            } label: {
                HStack {
                    Spacer()
                    
                    Text(buttonText)
                        .textStyle(
                            fontWeight: .medium,
                            size: 18,
                            color: .white
                        )
                    
                    Spacer()
                }
            }
            .setPadding(10)
            .background(
                Color.appMainColor
                    .cornerRadius(10, corners: .allCorners)
            )
            .setPadding(.horizontal, 33)
            .setPadding(.vertical, 10)
        }
    }
}

// MARK: - Preview
#Preview {
    ErrorView(
        image: .error_NoNetwork,
        title: Str.errorNoNetwork.key,
        message: Str.errorNoNetworkMessage.key,
        buttonText: Str.commonRetry.key,
        buttonAction: {
            debugPrint("Retry")
        }
    )
}
