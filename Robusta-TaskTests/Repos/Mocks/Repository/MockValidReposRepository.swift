//
//  MockValidReposRepository.swift
//  Robusta-TaskTests
//
//  Created by Abdelrhman Eliwa on 15/11/2022.
//

@testable import Robusta_Task
import Combine

final class MockValidReposRepository: ReposRepositoryContract {
    func fetchRepos(offset: Int?, limit: Int?) -> AnyPublisher<[ReposResponse], BaseError> {
        Just(MockData.repos())
            .eraseToBaseError()
            .eraseToAnyPublisher()
    }
}
