//
//  BaseResponse.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 09/11/2022.
//

import Foundation

struct BaseResponse<T: Decodable>: Decodable {
    var data: T?
}
