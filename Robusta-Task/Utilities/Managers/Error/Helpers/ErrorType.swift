//
//  ErrorType.swift
//
//  Created by Abdelrhman Eliwa on 19/05/2022.
//

import Foundation

enum ErrorType {
    // MARK: - Network
    case connection
    case unwrappedHttpClient
    case unwrappedHttpServer
    
    // MARK: - Decoder
    case mapping
    
    // MARK: - Local
    case logical
    case hardware
    case exception
    case permission
    case validation
    
    // MARK: - OTHER
    case unexpected
}
