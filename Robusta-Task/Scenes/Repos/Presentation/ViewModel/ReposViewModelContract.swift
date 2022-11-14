//
//  ReposViewModelContract.swift
//  Robusta-Task
//
//  Created by Abdelrhman Eliwa on 14/11/2022.
//

import Foundation

typealias ReposViewModelContract = ObservableObject & ReposViewModelInputs & ReposViewModelOutputs

protocol ReposViewModelInputs {
    func loadData()
}

protocol ReposViewModelOutputs {
    var repos: [ReposResponse] { get }
    var state: ViewModelState { get }
}
