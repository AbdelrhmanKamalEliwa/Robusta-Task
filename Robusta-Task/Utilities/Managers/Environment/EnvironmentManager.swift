//
//  EnvironmentManager.swift
//  Repositories
//
//  Created by Abdelrhman Eliwa on 09/11/2022.
//

import Foundation

final class EnvironmentManager {
    enum UserDefined: String {
        case productName = "CFBundleName"
        case productBundle = "CFBundleIdentifier"
        case productVersion = "CFBundleShortVersionString"
        case productBuild = "CFBundleVersion"
        
        case serverScheme = "SERVER_SCHEME"
        case serverHost = "SERVER_HOST"
    }
    
    static let shared = EnvironmentManager()
    
    private var infoDict: [String: Any]
    
    private init() {
        guard let dict = Bundle.main.infoDictionary else {
            fatalError("Couldn't find plist file")
        }
        
        infoDict = dict
    }
    
    /// Method to fetch String value from Info.plist
    /// - Parameter key: Key to fetch from Info.plist
    /// - Returns: Value fetched from Info.plist
    func string(key: UserDefined) -> String {
        return self.fetch(key: key.rawValue)
    }
    
    /// Method to fetch Boolean value from Info.plist
    /// - Parameter key: Key to fetch from Info.plist
    /// - Returns: Value fetched from Info.plist
    func boolean(key: UserDefined) -> Bool {
        return self.infoDict[key.rawValue] as? Bool ?? false
    }
    
    /// Method to fetch Dictionary value from Info.plist
    /// - Parameter key: Key to fetch from Info.plist
    /// - Returns: Value fetched from Info.plist
    func dictionary(key: UserDefined) -> [String: Any] {
        return (self.infoDict[key.rawValue] as? [String: Any]).value
    }
    
    /// Method to fetch String value from Info.plist
    /// - Parameter key: Key to fetch from Info.plist
    /// - Returns: Value fetched from Info.plist
    private func fetch(key: String) -> String {
        return (self.infoDict[key] as? String).value
    }
}
