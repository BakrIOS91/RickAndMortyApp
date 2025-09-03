//
//  AppEnums.swift
//  RickAndMorty
//
//  Created by Bakr mohamed on 03/09/2025.
//

import SwiftUI
import BMSwiftNetworking

enum Page {
    case first
    case next
}

enum ViewState: Equatable {
    case loading
    case overlayLoading(Color = .white)
    case loaded
    case noNetwork
    case noData
    case serverError
    case searchError
    case unExpectedError
    
    
    static func failHandler(_ apiError: APIError) -> Self {
        switch apiError {
        case .invalidURL:
            return .unExpectedError
        case .dataConversionFailed:
            return .unExpectedError
        case .stringConversionFailed:
            return .unExpectedError
        case .httpError(let statusCode):
            switch statusCode {
            case .notAuthorize:
                return .serverError
            default:
                return .serverError
            }
        case .noNetwork:
            return .noNetwork
        default:
            return .unExpectedError
        }
    }
    
}
