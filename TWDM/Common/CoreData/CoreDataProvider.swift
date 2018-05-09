//
//  CoreDataProvider.swift
//  TWDM
//
//  Created by yuki.kuroda on 2018/04/30.
//  Copyright © 2018年 darquro. All rights reserved.
//

import UIKit
import CoreData

class CoreDataProvider {

    static let directMessages = CoreDataProvider(name: "DirectMessages")
    
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: name)
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}
