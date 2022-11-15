//
//  MockValidFetchReposUseCase.swift
//  Robusta-TaskTests
//
//  Created by Abdelrhman Eliwa on 15/11/2022.
//

import Foundation
import Combine
@testable import Robusta_Task

final class MockValidFetchReposUseCase: FetchReposUseCaseContract {
    func execute(offset: Int?, limit: Int?) -> AnyPublisher<[ReposResponse], BaseError> {
        Just(MockData.repos())
            .eraseToBaseError()
            .eraseToAnyPublisher()
    }
}
