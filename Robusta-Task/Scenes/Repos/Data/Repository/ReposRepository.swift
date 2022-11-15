//
//  ReposRepository.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 09/11/2022.
//

import Combine

final class ReposRepository: DisposeObject, ReposRepositoryContract {
    // MARK: - PROPERTIES
    //
    private let localService: ReposLocalServiceContract
    private let remoteService: ReposRemoteServiceContract
    private let userDefaults: UserDefaultsManagerContract
    
    private var didGetRepoFromRemote: Bool {
        userDefaults.getValue(for: .didGetReposFromRemote) as? Bool ?? false
    }
    
    // MARK: - INIT
    //
    init(
        localService: ReposLocalServiceContract = ReposLocalService(),
        remoteService: ReposRemoteServiceContract = ReposRemoteService(),
        userDefaults: UserDefaultsManagerContract = UserDefaultsManager.shared
    ) {
        self.localService = localService
        self.remoteService = remoteService
        self.userDefaults = userDefaults
        
        super.init()
    }
    
    // MARK: - METHODS
    //
    func fetchRepos(offset: Int? = nil, limit: Int? = nil) -> AnyPublisher<[ReposResponse], BaseError> {
        
        if didGetRepoFromRemote {
            return fetchFromLocal(offset: offset, limit: limit)
        }
        
        return fetchFromRemoteAndCacheData()
    }
    
    func searchOnRepos(with text: String) -> AnyPublisher<[ReposResponse], BaseError> {
        localService
            .searchOnRepos(with: text)
            .map { items in
                return items.map {
                    ReposResponse(
                        id: $0.id.int,
                        name: $0.name,
                        fullName: $0.fullName,
                        isPrivate: $0.isPrivate,
                        owner: .init(id: $0.ownerId.int, avatarURL: $0.ownerAvatarURL)
                    )
                }
            }
            .eraseToBaseError()
            .eraseToAnyPublisher()
    }
}

// MARK: - HELPERS
//
private extension ReposRepository {
    func fetchFromRemote() -> AnyPublisher<[ReposResponse], BaseError> {
        return remoteService
            .fetchRepos()
            .eraseToBaseError()
            .eraseToAnyPublisher()
    }
    
    func fetchFromRemoteAndCacheData() -> AnyPublisher<[ReposResponse], BaseError> {
        deleteRepos()
            .sink { completion in
                if case let .failure(error) = completion {
                    print(error)
                }
            } receiveValue: { _ in
                print("Repos Deleted Successfully")
            }
            .store(in: &cancellables)

        
        return remoteService
            .fetchRepos()
            .handleEvents(receiveOutput: { [weak self] repos in
                guard let self = self else { return }
                repos.forEach { repo in
                    self.addRepo(repo)
                        .sink(receiveCompletion: { completion in
                            if case let .failure(error) = completion {
                                print(error)
                            }
                        }, receiveValue: { repo in
                            print("\(String(describing: repo.id)) saved successfully")
                        })
                        .store(in: &self.cancellables)
                }
                
                self.userDefaults.set(value: true, for: .didGetReposFromRemote)
            })
            .eraseToBaseError()
            .eraseToAnyPublisher()
    }
    
    func fetchFromLocal(offset: Int? = nil, limit: Int? = nil) -> AnyPublisher<[ReposResponse], BaseError> {
        localService
            .fetchRepos(offset: offset, limit: limit)
            .map { items in
                return items.map {
                    ReposResponse(
                        id: $0.id.int,
                        name: $0.name,
                        fullName: $0.fullName,
                        isPrivate: $0.isPrivate,
                        owner: .init(id: $0.ownerId.int, avatarURL: $0.ownerAvatarURL)
                    )
                }
            }
            .eraseToBaseError()
            .eraseToAnyPublisher()
    }
    
    func addRepo(_ repo: ReposResponse) -> AnyPublisher<ReposResponse, BaseError> {
        return localService
            .addRepo(repo)
            .map {
                ReposResponse(
                    id: $0.id.int,
                    name: $0.name,
                    fullName: $0.fullName,
                    isPrivate: $0.isPrivate,
                    owner: .init(id: $0.ownerId.int, avatarURL: $0.ownerAvatarURL)
                )
            }
            .eraseToBaseError()
            .eraseToAnyPublisher()
    }
    
    func deleteRepos() -> AnyPublisher<Void, Error> {
        localService.deleteRepos()
    }
}
