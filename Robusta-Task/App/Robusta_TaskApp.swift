//
//  Robusta_TaskApp.swift
//  Robusta-Task
//
//  Created by Abdelrhman Eliwa on 14/11/2022.
//

import SwiftUI

@main
struct Robusta_TaskApp: App {
    // MARK: - INIT
    //
    init() {
        setupCoreData()
    }
    
    // MARK: - BODY
    //
    var body: some Scene {
        WindowGroup {
            ReposView()
        }
    }
}

// MARK: - HELPERS
//
private extension Robusta_TaskApp {
    func setupCoreData() {
        let coreDataContext: CoreDataStorageContext = .init(
            fileName: "Robusta_Task",
            bundle: .main,
            storeType: .sqLiteStoreType
        )
        
        CoreDataManager.setup(coreDataStorageContext: coreDataContext)
    }
}
