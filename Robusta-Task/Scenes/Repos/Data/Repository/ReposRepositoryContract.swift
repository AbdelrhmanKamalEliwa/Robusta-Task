//
//  ReposRepositoryContract.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 09/11/2022.
//

import Combine

protocol ReposRepositoryContract {
    func fetchRepos(offset: Int?, limit: Int?) -> AnyPublisher<[ReposResponse], BaseError>
}
