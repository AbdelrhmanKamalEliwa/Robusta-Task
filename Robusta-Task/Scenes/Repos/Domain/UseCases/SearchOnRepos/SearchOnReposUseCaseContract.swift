//
//  SearchOnReposUseCaseContract.swift
//  Robusta-Task
//
//  Created by Abdelrhman Eliwa on 15/11/2022.
//

import Combine

protocol SearchOnReposUseCaseContract {
    func execute(with text: String) -> AnyPublisher<[ReposResponse], BaseError>
}
