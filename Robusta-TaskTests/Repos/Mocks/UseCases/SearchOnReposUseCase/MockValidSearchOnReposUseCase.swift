//
//  MockValidSearchOnReposUseCase.swift
//  Robusta-TaskTests
//
//  Created by Abdelrhman Eliwa on 15/11/2022.
//

import Foundation
import Combine
@testable import Robusta_Task

final class MockValidSearchOnReposUseCase: SearchOnReposUseCaseContract {
    func execute(with text: String) -> AnyPublisher<[ReposResponse], BaseError> {
        Just(MockData.filterdRepos)
            .eraseToBaseError()
            .eraseToAnyPublisher()
    }
}
