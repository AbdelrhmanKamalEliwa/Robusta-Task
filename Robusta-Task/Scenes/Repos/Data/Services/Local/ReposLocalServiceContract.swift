//
//  ReposLocalServiceContract.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 09/11/2022.
//

import Combine

protocol ReposLocalServiceContract {
    func fetchRepos(offset: Int?, limit: Int?) -> AnyPublisher<[Repo], Error>
    func searchOnRepos(with text: String) -> AnyPublisher<[Repo], Error>
    func addRepo(_ repo: ReposResponse) -> AnyPublisher<Repo, Error>
    func deleteRepos() -> AnyPublisher<Void, Error>
}
