//
//  NetworkConstants.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 09/11/2022.
//

import Foundation

public enum NetworkConstants {
    enum Range {
        static let statusCode = 200...299
    }
    
    static let retries: Int = 3
    static let baseUrl: String = getBaseUrl()
    static let timeoutIntervalForRequest: Double = 120
    
    private static func getBaseUrl() -> String {
        let scheme = EnvironmentManager.shared.string(key: .serverScheme)
        let host = EnvironmentManager.shared.string(key: .serverHost)
        return "\(scheme)://\(host)"
    }
}
