//
//  ViewModelState.swift
//  Robusta-Task
//
//  Created by Abdelrhman Eliwa on 14/11/2022.
//

import Foundation

enum ViewModelState: Comparable {
    case idle
    case loading
    case loadedAll
    case error(String)
}
