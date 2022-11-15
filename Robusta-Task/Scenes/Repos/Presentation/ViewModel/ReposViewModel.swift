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
    @Published var searchText: String = ""
    @Published var state: ViewModelState
    @Published var isSearching: Bool = false
    private var searchOnReposUseCase: SearchOnReposUseCaseContract
    private var fetchReposUseCase: FetchReposUseCaseContract
    private var fetchOffset: Int
    private var fetchLimit: Int
    private var maxCount: Int
    
    private var cachedDataSource: [ReposResponse] = []
    
    // MARK: - INIT
    //
    init(
        fetchReposUseCase: FetchReposUseCaseContract = FetchReposUseCase(),
        searchOnReposUseCase: SearchOnReposUseCaseContract = SearchOnReposUseCase(),
        maxCount: Int = 100,
        state: ViewModelState = .idle
    ) {
        self.fetchReposUseCase = fetchReposUseCase
        self.searchOnReposUseCase = searchOnReposUseCase
        self.maxCount = maxCount
        self.state = state
        self.fetchOffset = 0
        self.fetchLimit = 10
        
        super.init()
        loadData()
        listenOnSearchText()
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
    func listenOnSearchText() {
        $searchText
            .dropFirst()
            .sink { [weak self] text in
                guard let self = self else { return }
                if text.isEmpty {
                    self.isSearching = false
                    self.repos = self.cachedDataSource
                } else if text.count >= 2 {
                    self.isSearching = true
                    self.searchFor(text)
                } else {
                    self.isSearching = true
                    self.repos = []
                }
            }
            .store(in: &cancellables)
    }
    
    func searchFor(_ text: String) {
        state = .loading
        
        searchOnReposUseCase
            .execute(with: text)
            .sink { [weak self] completion in
                guard let self = self else { return }
                if case let .failure(error) = completion {
                    self.state = .error(error.localizedDescription)
                }
            } receiveValue: { [weak self] repos in
                guard let self = self else { return }
                if repos.isEmpty {
                    self.state = .error("Repos not found")
                } else {
                    self.state = .idle
                    self.repos = repos
                }
            }
            .store(in: &cancellables)
    }
    
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
                    self.cachedDataSource = Array(repos[self.fetchOffset ..< self.fetchLimit])
                } else {
                    self.repos.append(contentsOf: repos)
                    self.cachedDataSource.append(contentsOf: repos)
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
