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
    @Published var state: ViewModelState = .idle
    private var fetchReposUseCase: FetchReposUseCaseContract
    private var fetchOffset: Int
    private var fetchLimit: Int
    private var maxCount = 100
    
    // MARK: - INIT
    //
    init(
        fetchReposUseCase: FetchReposUseCaseContract = FetchReposUseCase()
    ) {
        self.fetchReposUseCase = fetchReposUseCase
        self.fetchOffset = 0
        self.fetchLimit = 10
        
        super.init()
    }
    
    // MARK: - METHODS
    //
    func loadData() {
        guard state == .idle, state != .loadedAll else { return }
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
                self.state = .idle
                self.repos.append(contentsOf: repos)
                if self.repos.count == self.maxCount {
                    self.state = .loadedAll
                }
                self.fetchOffset += self.fetchLimit
            }
            .store(in: &cancellables)
    }
}
