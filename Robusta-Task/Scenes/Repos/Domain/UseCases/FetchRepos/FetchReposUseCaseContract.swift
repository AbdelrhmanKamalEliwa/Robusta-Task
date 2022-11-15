//
//  FetchReposUseCaseContract.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 10/11/2022.
//

import Combine

protocol FetchReposUseCaseContract {
    func execute(offset: Int?, limit: Int?) -> AnyPublisher<[ReposResponse], BaseError>
}
