//
//  ReposRemoteServiceContract.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 09/11/2022.
//

import Combine

protocol ReposRemoteServiceContract {
    func fetchRepos() -> AnyPublisher<[ReposResponse], BaseError>
}
