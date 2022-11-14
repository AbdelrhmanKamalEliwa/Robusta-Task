//
//  APIServiceContract.swift
//
//  Created by Abdelrhman Eliwa on 15/11/2021.
//

import Foundation
import Combine

protocol APIServiceContract {
    // MARK: - request API Service
    func request<T: Decodable>(
        using request: URLRequest,
        responseType: T.Type,
        decoder: JSONDecoder,
        retry: Int
    ) -> AnyPublisher<T, BaseError>
}

// MARK: - APIServiceContract+Handle request func default values
extension APIServiceContract {
    func request<T: Decodable>(
        using request: URLRequest,
        responseType: T.Type
    ) -> AnyPublisher<T, BaseError> {
        self.request(
            using: request,
            responseType: responseType,
            decoder: JSONDecoder(),
            retry: NetworkConstants.retries
        )
    }
}
