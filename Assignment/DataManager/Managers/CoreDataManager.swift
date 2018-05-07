//
//  CoreDataManager.swift
//
//  Created by Monu on 12/12/17.
//  Copyright © 2017 Appster. All rights reserved.
//

import Foundation
import Contacts
import CoreData

class CoreDataManager: NSObject {

    // Main and background context
    var mainContext: NSManagedObjectContext! // Read only context
    var backgroundContext: NSManagedObjectContext! // Write only context

    // get default context
    var defaultContext: NSManagedObjectContext {
        if Thread.isMainThread {
            return mainContext
        } else {
            return backgroundContext
        }
    }

    // Shared database manager
    static let shared: CoreDataManager = CoreDataManager()

    // Pure singleton
    private override init() {
        super.init()
        // Initialize private context.
        mainContext = persistentContainer.viewContext
        backgroundContext = persistentContainer.newBackgroundContext()
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Assignment")
        container.loadPersistentStores(completionHandler: { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Helper
    // Save current context
    func saveContext(handler: ((_ done: Bool, _ error: Error?) -> Void)? = nil) {
        if defaultContext.hasChanges {
            defaultContext.perform {
                do {
                    try self.defaultContext.save()
                    handler?(true, nil)
                } catch {
                    handler?(false, error)
                }
            }
        } else {
            handler?(true, nil)
        }
    }
}

extension NSManagedObject {
    
    static var entityName: String {
        return String(describing: self)
    }
    
    // MARK: - Generics methods
    
    // Fetch objects
    class func fetch<T>(type _: T.Type, page: Int = 0, pageSize: Int = 20, predicateFormat: String? = nil, sortDescriptors: [NSSortDescriptor]? = nil) -> [T] {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: entityName)
        
        // Create paging
        if page > 0 {
            request.fetchLimit = pageSize
            request.fetchOffset = (page - 1) * pageSize
        }
        
        // Adding predicate
        if let format = predicateFormat {
            request.predicate = NSPredicate(format: format)
        }
        
        // Adding sort descriptor
        if let descriptors = sortDescriptors {
            request.sortDescriptors = descriptors
        }
        
        do {
            // Fetch records from database
            if let fetchedResult = try CoreDataManager.shared.defaultContext.fetch(request) as? [T] {
                return fetchedResult
            }
        } catch {
            print("Failed to fetch \(entityName): \(error)")
        }
        return []
    }
    
    // Remove all objects
    class func removeAll<T>(type: T.Type, predicateFormat: String? = nil) {
        let objects = fetch(type: type, predicateFormat: predicateFormat)
        let context = CoreDataManager.shared.defaultContext
        for item in objects {
            if let deletedObject = item as? NSManagedObject {
                context.delete(deletedObject)
            }
        }
        
        // Save updated context.
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print("Error to save context data error: \(error)")
            }
        }
    }
}
