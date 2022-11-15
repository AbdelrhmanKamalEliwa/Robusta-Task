//
//  Publisher.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 09/11/2022.
//

import Combine

extension Publisher {
    /// Use this func to map error to the `BaseError`
    /// - Returns: `Publishers.MapError<Self, BaseError>`
    func eraseToBaseError() -> Publishers.MapError<Self, BaseError> {
        return self
            .mapError { (error: Self.Failure) -> BaseError in
                guard let baseError = error as? BaseError else {
                    return ErrorResolver.shared.getError(for: .unexpected)
                }
                
                return baseError
            }
    }
}
