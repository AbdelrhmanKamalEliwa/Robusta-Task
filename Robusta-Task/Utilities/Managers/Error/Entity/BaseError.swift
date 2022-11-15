//
//  BaseError.swift
//
//  Created by Abdelrhman Eliwa on 19/05/2022.
//

import Foundation

struct BaseError: Error {
    let code: Int?
    let message: String?
}

extension BaseError: Equatable {}
