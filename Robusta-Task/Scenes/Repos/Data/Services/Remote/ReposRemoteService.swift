//
//  ReposRemoteService.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 09/11/2022.
//

import Foundation
import Combine

final class ReposRemoteService: DisposeObject, ReposRemoteServiceContract {
    // MARK: - Properties
    //
    private let apiService: APIServiceContract
    
    // MARK: - INIT
    
    init(apiService: APIServiceContract = APIService.shared) {
        self.apiService = apiService
        super.init()
    }
    
    // MARK: - SERVICE METHODS
    //
    func fetchRepos() -> AnyPublisher<[ReposResponse], BaseError> {
        let request = APIBuilder()
            .setPath(using: .repositories)
            .setMethod(using: .get)
            .build()
            
        return apiService
            .request(using: request, responseType: [ReposResponse].self)
    }
}
