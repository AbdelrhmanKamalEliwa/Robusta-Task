//
//  ReposLocalService.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 09/11/2022.
//

import Foundation
import Combine

final class ReposLocalService: DisposeObject, ReposLocalServiceContract {
    // MARK: - Properties
    //
    private let coreDataManager: CoreDataManager
    
    private var managedObject: CoreDataRepository<Repo> {
        guard let coreDataContext = try? coreDataManager.storageContext() else {
            fatalError()
        }
        return CoreDataRepository<Repo>(coreDataStorageContext: coreDataContext)
    }
    
    // MARK: - INIT
    //
    init(coreDataManager: CoreDataManager = CoreDataManager.shared) {
        self.coreDataManager = coreDataManager
        super.init()
    }
    
    // MARK: - SERVICE METHODS
    //
    func fetchRepos(offset: Int? = nil, limit: Int? = nil) -> AnyPublisher<[Repo], Error> {
        return managedObject
            .fetch(offset: offset, limit: limit)
    }
    
    func addRepo(_ repo: ReposResponse) -> AnyPublisher<Repo, Error> {
        return managedObject
            .insert { newRepo in
                if let id = repo.id?.int64 {
                    newRepo.id = id
                }
                newRepo.name = repo.name
                newRepo.fullName = repo.fullName
                if let id = repo.id?.int64 {
                    newRepo.ownerId = id
                }
                newRepo.ownerAvatarURL = repo.owner?.avatarURL
            }
    }
    
    func deleteRepos() -> AnyPublisher<Void, Error> {
        managedObject.deleteAll()
    }
    
    func searchOnRepos(with text: String) -> AnyPublisher<[Repo], Error> {
        managedObject.fetch(
//            sortDescriptors: [SortDescriptor<Repo>(\.name)],
            predicate: NSPredicate(format: "name contains[c] %@", text)
        )
    }
}
