//
//  ErrorResolver.swift
//
//  Created by Abdelrhman Eliwa on 19/05/2022.
//

import Foundation

final class ErrorResolver {
    static let shared = ErrorResolver()
    
    private init() { }
    
    func getError(for type: ErrorType) -> BaseError {
        return .init(
            code: type.code,
            message: type.message
        )
    }
    
    func getError(with error: Error) -> BaseError {
        return BaseError(
            code: -1,
            message: error.localizedDescription
        )
    }
}
