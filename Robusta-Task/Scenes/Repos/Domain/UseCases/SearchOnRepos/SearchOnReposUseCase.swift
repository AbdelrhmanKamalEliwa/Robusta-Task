//
//  SearchOnReposUseCase.swift
//  Robusta-Task
//
//  Created by Abdelrhman Eliwa on 15/11/2022.
//

import Combine

final class SearchOnReposUseCase: DisposeObject, SearchOnReposUseCaseContract {
    
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
    
    func execute(with text: String) -> AnyPublisher<[ReposResponse], BaseError> {
        return repository
            .searchOnRepos(with: text)
    }
}
