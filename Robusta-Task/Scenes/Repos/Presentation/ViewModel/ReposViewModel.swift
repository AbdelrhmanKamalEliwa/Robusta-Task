//
//  ReposViewModel.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 09/11/2022.
//

import Foundation
import Combine

class ReposViewModel: DisposeObject, ObservableObject {
    
    enum State: Comparable {
        case idle
        case loading
        case loadedAll
        case error(String)
    }
    
    @Published var items: [ReposResponse] = []
    @Published var state: State = .idle
    
    private var fetchReposUseCase: FetchReposUseCaseContract
    private var fetchOffset: Int
    private var fetchLimit: Int
    private var maxCount = 100
    
    init(fetchReposUseCase: FetchReposUseCaseContract = FetchReposUseCase()) {
        self.fetchReposUseCase = fetchReposUseCase
        self.fetchOffset = 0
        self.fetchLimit = 10
        
        super.init()
    }
    
    func didLoad() {
        self.fetchLimit = 10
        self.fetchOffset = 0
        fetchData()
    }
    
    func loadMore() {
        guard state == .idle, state != .loadedAll else { return }
        fetchData()
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
                self.state = .idle
                self.items.append(contentsOf: repos)
                if self.items.count == self.maxCount {
                    self.state = .loadedAll
                }
                self.fetchOffset += self.fetchLimit
            }
            .store(in: &cancellables)
    }
}
