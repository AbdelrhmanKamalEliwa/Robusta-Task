//
//  ReposViewModel.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 09/11/2022.
//

import Foundation
import Combine

class ReposViewModel: DisposeObject, ReposViewModelContract {
    // MARK: - PROPERTIES
    //
    @Published var repos: [ReposResponse] = []
    @Published var state: ViewModelState
    private var fetchReposUseCase: FetchReposUseCaseContract
    private var fetchOffset: Int
    private var fetchLimit: Int
    private var maxCount: Int
    
    // MARK: - INIT
    //
    init(
        fetchReposUseCase: FetchReposUseCaseContract = FetchReposUseCase(),
        maxCount: Int = 100,
        state: ViewModelState = .idle
    ) {
        self.fetchReposUseCase = fetchReposUseCase
        self.maxCount = maxCount
        self.state = state
        self.fetchOffset = 0
        self.fetchLimit = 10
        
        super.init()
        loadData()
    }
    
    // MARK: - METHODS
    //
    func loadData() {
        guard state == .idle else { return }
        fetchData()
    }
}

// MARK: - HELPERS
//
private extension ReposViewModel {
    func fetchData() {
        state = .loading
        
        fetchReposUseCase
            .execute(offset: fetchOffset, limit: fetchLimit)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self = self else { return }
                if case let .failure(error) = completion {
                    self.state = .error(error.localizedDescription)
                }
            } receiveValue: { [weak self] repos in
                guard let self = self else { return }
                
                if self.repos.isEmpty {
                    self.repos = Array(repos[self.fetchOffset ..< self.fetchLimit])
                } else {
                    self.repos.append(contentsOf: repos)
                }
                
                if self.repos.count == self.maxCount {
                    self.state = .loadedAll
                } else {
                    self.state = .idle
                }
                
                self.fetchOffset += self.fetchLimit
            }
            .store(in: &cancellables)
    }
}
