//
//  WithViewState.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 03/09/2025.
//

import BMSwiftUI
import SwiftUI
import LoaderUI

struct WithViewState<Content: View>: View {
    let content: () -> Content
    @State private var isRefreshable: Bool
    @Binding private var viewState: ViewState
    private var retryAction: () -> Void

    init(
        viewState: Binding<ViewState>,
        isRefreshable: Bool = false,
        _ content: @escaping () -> Content,
        retryAction: @escaping () -> Void = {},
    ) {
        self._viewState = viewState
        self.isRefreshable = isRefreshable
        self.content = content
        self.retryAction = retryAction
    }
    

    var body: some View {
        ZStack {
            Color.appMainBackground.ignoresSafeArea()
            contentView
            loadingOverlay
        }
    }

    @ViewBuilder
    private var contentView: some View {
        if isRefreshable && viewState == .loaded {
            content()
                .refreshable {
                    retryAction()
                }
        } else {
            content()
        }
    }

    @ViewBuilder
    private var loadingOverlay: some View {
        switch viewState {
        case .loading:
            ZStack {
                Color.white.opacity(0.001)
                    .ignoresSafeArea()
                loaderView
            }
        case let .overlayLoading(color):
            ZStack {
                color
                loaderView
            }
        case .noNetwork:
            ErrorView(
                viewState: $viewState,
                image: .error_NoNetwork,
                title: Str.errorNoNetwork.key,
                message: Str.errorNoNetworkMessage.key,
                buttonText: Str.commonRetry.key,
                buttonAction: retryAction
            )
        case .noData:
            ErrorView(
                image: .error_NoDataa,
                title: Str.errorNoData.key,
                message: Str.errorNoDataMessage.key
            )
            
        case .serverError:
            ErrorView(
                viewState: $viewState,
                image: .error_ServerError,
                title: Str.errorServer.key,
                message: Str.errorServerMessage.key,
                buttonText: Str.commonRetry.key,
                buttonAction: retryAction
            )
            
        case .searchError:
            ErrorView(
                image: .error_Search,
                title: Str.errorSearch.key,
            )
            
        case .unExpectedError:
            ErrorView(
                viewState: $viewState,
                image: .error_UnExpected,
                title: Str.errorUnExpectedError.key,
                message: Str.errorUnExpectedErrorMessage.key,
                buttonText: Str.commonRetry.key,
                buttonAction: retryAction
            )
        default:
            EmptyView()
        }
    }
    
    private var loaderView: some View {
        BallPulseSync()
            .frame(width: 200, height: 60, alignment: .center)
            .foregroundColor(.appMainColor)
    }
}

#Preview {
    @Previewable @State var viewState: ViewState = .noNetwork
    
    WithViewState(viewState: $viewState) {
        VStack{
            Text("Some View")
        }
    }
}

