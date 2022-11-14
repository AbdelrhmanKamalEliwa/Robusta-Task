//
//  CoreDataStoreType.swift
//
//  Created by Abdelrhman Eliwa on 03/05/2022.
//

import CoreData

/// The persistentStore type
/// -  sqLite
/// - inMemory
public enum CoreDataStoreType: String {
    case sqLiteStoreType
    case inMemoryStoreType
}

extension CoreDataStoreType {
    var value: String {
        switch self {
        case .sqLiteStoreType:
            return NSSQLiteStoreType
        case .inMemoryStoreType:
            return NSInMemoryStoreType
        }
    }
}
