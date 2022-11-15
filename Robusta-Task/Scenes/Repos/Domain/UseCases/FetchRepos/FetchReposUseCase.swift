//
//  FetchReposUseCase.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 10/11/2022.
//

import Combine

final class FetchReposUseCase: DisposeObject, FetchReposUseCaseContract {
    // MARK: - PROPERTIES
    //
    private let repository: ReposRepositoryContract
    
    // MARK: - INIT
    //
    init(repository: ReposRepositoryContract = ReposRepository()) {
        self.repository = repository
        
        super.init()
    }
    
    // MARK: - METHODS
    //
    func execute(offset: Int?, limit: Int?) -> AnyPublisher<[ReposResponse], BaseError> {
        return repository
            .fetchRepos(offset: offset, limit: limit)
    }
}
