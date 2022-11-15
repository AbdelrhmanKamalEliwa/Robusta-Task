//
//  ReposViewModelContract.swift
//  Robusta-Task
//
//  Created by Abdelrhman Eliwa on 14/11/2022.
//

import Foundation

typealias ReposViewModelContract = ObservableObject & ReposViewModelInputs & ReposViewModelOutputs

protocol ReposViewModelInputs {
    var searchText: String { get set }
    func loadData()
}

protocol ReposViewModelOutputs {
    var repos: [ReposResponse] { get }
    var state: ViewModelState { get }
    var isSearching: Bool { get }
}
