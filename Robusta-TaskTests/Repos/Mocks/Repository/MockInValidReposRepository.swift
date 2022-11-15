//
//  MockInValidReposRepository.swift
//  Robusta-TaskTests
//
//  Created by Abdelrhman Eliwa on 15/11/2022.
//

@testable import Robusta_Task
import Combine

final class MockInValidReposRepository: ReposRepositoryContract {
    func searchOnRepos(with text: String) -> AnyPublisher<[ReposResponse], BaseError> {
        Fail(error: MockData.unexpectedError)
            .eraseToAnyPublisher()
    }
    
    func fetchRepos(offset: Int?, limit: Int?) -> AnyPublisher<[ReposResponse], BaseError> {
        Fail(error: MockData.unexpectedError)
            .eraseToAnyPublisher()
    }
}
