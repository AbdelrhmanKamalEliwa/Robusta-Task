//
//  RepoDetailsViewModel.swift
//  Robusta-Task
//
//  Created by Abdelrhman Eliwa on 15/11/2022.
//

import Foundation

class RepoDetailsViewModel: DisposeObject, RepoDetailsViewModelContract {
    // MARK: - PROPERTIES
    //
    var repo: ReposResponse
    
    // MARK: - INIT
    init(repo: ReposResponse) {
        self.repo = repo
    }
}
