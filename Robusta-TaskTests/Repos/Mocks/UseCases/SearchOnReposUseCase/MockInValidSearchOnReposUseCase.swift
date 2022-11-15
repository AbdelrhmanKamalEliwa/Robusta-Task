//
//  MockInValidSearchOnReposUseCase.swift
//  Robusta-TaskTests
//
//  Created by Abdelrhman Eliwa on 15/11/2022.
//

import Foundation
import Combine
@testable import Robusta_Task

final class MockInValidSearchOnReposUseCase: SearchOnReposUseCaseContract {
    func execute(with text: String) -> AnyPublisher<[ReposResponse], BaseError> {
        Fail(error: MockData.unexpectedError)
            .eraseToAnyPublisher()
    }
}
