//
//  CoreDataManager.swift
//  TopAnime
//
//  Created by Mohamed Rwash on 9/29/18.
//  Copyright © 2018 mrwash. All rights reserved.
//

import Foundation
import CoreData

struct CoreDataManager {
    static let shared = CoreDataManager()
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TopAnimeModels")
        container.loadPersistentStores { (storeDesc, error) in
            if let error = error{
                print("Loading Persistent Container Fail: ", error)
            }
        }
        return container
    }()
}
