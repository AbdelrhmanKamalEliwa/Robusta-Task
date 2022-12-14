//
//  CoreDataStorageContext.swift
//
//  Created by Abdelrhman Eliwa on 03/05/2022.
//

import CoreData

/// This class is container for the Core data NSManagedObjectModel, NSPersistentContainer ansNSManagedObjectContext instanses
///
public final class CoreDataStorageContext {
    private let fileName: String
    private let bundle: Bundle
    private let storeType: CoreDataStoreType
    
    private lazy var managedObjectModel: NSManagedObjectModel? = initManagedObjectModel()
    private lazy var persistentContainer: NSPersistentContainer? = initPersistentContainer()
    
    private lazy var forgroundContext: NSManagedObjectContext? = {
        let context = persistentContainer?.viewContext
        context?.automaticallyMergesChangesFromParent = true
        return context
    }()
    
    
    /// This method sets the coreDataStorageContext
    /// - Parameters:
    ///   - fileName: String -> the xcdatamodeld file name
    ///   - bundle: Bundle -> the bundle for the xcdatamodeld file
    ///   - storeType: CoreDataStoreType -> persistentStore type (inMemory or sqLite)
     /**
    - Example
    ```
     let coreDataContext: CoreDataStorageContext = .init(
                 fileName: "UserManagement",
                 bundle: .main,
                 storeType: .sqLiteStoreType
             )
    ```
    */
    public init(
        fileName: String,
        bundle: Bundle = .main,
        storeType: CoreDataStoreType = .sqLiteStoreType
    ) {
        self.fileName = fileName
        self.bundle = bundle
        self.storeType = storeType
    }
}

// MARK: - CoreDataStorageContextContract

extension CoreDataStorageContext: CoreDataStorageContextContract {
    public func getForgroundContext() -> NSManagedObjectContext? {
        return forgroundContext
    }
    
    public func getBackgroundContext() -> NSManagedObjectContext? {
        let context = persistentContainer?.newBackgroundContext()
        context?.mergePolicy = NSMergePolicy.mergeByPropertyStoreTrump
        return context
    }
}

// MARK: - Private Helpers

private extension CoreDataStorageContext {
    func initManagedObjectModel() -> NSManagedObjectModel? {
        guard let modelURL = FileManager.shared.getFile(
            fileName,
            withExtension: .coreData,
            from: bundle
        ) else {
            print("\(fileName) not found in bundle: \(bundle)")
            return nil
        }
        
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: modelURL) else {
            print("Can't get NSManagedObjectModel from \(modelURL.absoluteString)")
            return nil
        }
        
        return managedObjectModel
    }
    
    func initPersistentContainer() -> NSPersistentContainer? {
        guard let managedObjectModel = managedObjectModel else { return nil }
        
        let persistentContainer = NSPersistentContainer(
            name: fileName,
            managedObjectModel: managedObjectModel
        )
        let description = persistentContainer.persistentStoreDescriptions.first
        description?.type = storeType.value
        
        persistentContainer.loadPersistentStores { description, error in
            if let error = error {
                print("was unable to load store \(error)")
            }
        }
        
        return persistentContainer
    }
}


