//
//  RepoDetailsViewModelContract.swift
//  Robusta-Task
//
//  Created by Abdelrhman Eliwa on 15/11/2022.
//

import Foundation

typealias RepoDetailsViewModelContract = ObservableObject & RepoDetailsViewModelInputs & RepoDetailsViewModelOutputs

protocol RepoDetailsViewModelInputs { }

protocol RepoDetailsViewModelOutputs {
    var repo: ReposResponse { get }
}
