//
//  Persistence.swift
//  InvestmentTracker
//
//  Created by Roman Kavinskyi on 12/18/21.
//

import CoreData
import Combine

struct PersistenceManager {
    static let shared = PersistenceManager()

    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    var backgroundContext: NSManagedObjectContext {
        container.newBackgroundContext()
    }
    
    func save() {
        guard viewContext.hasChanges else {
        print("😕😕😕 Saving context with no changes!!!!!!!!")
            return
        }
        do {
            try viewContext.save()
        } catch {
            print(error.localizedDescription)
            viewContext.rollback()
            fatalError("Error saving data")
        }
    }
    
    func getAllInvestments() -> [Investment] {
        let request: NSFetchRequest<Investment> = Investment.fetchRequest()

        do {
            return try viewContext.fetch(request)
        } catch {
            fatalError("Error Fetching Users")
        }
    }
    
    func deleteInvestment(_ investment: Investment) {
        viewContext.delete(investment)
        save()
    }


    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "InvestmentTracker")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
