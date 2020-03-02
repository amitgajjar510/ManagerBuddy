//
//  DatabaseManager.swift
//  ManagerBuddy
//
//  Created by Amit Gajjar on 02/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import Foundation
import CoreData

class DatabaseManager {
    // MARK: - Singleton Method

    static let shared: DatabaseManager = DatabaseManager()
    private init() {}

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "ManagerBuddy")
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
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

    // MARK: - CRUD Methods

    func cleanUpEmployees() {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "EmployeeEntity")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        do {
            try managedObjectContext.execute(batchDeleteRequest)
        } catch let error as NSError {
            print(error)
        }

        do {
            try managedObjectContext.save()
        }
        catch let error {
            print("Could not batch delete from core data: \(error.localizedDescription)")
        }
    }

    func storeEmployees(withEmployees employees: [Employee]) {
        let managedObjectContext = persistentContainer.viewContext
        guard let entity: NSEntityDescription = NSEntityDescription.entity(forEntityName: "EmployeeEntity", in: managedObjectContext)
            else {
                return
        }
        for employee in employees {
            let employeeEntity: EmployeeEntity = EmployeeEntity(entity: entity, insertInto: managedObjectContext)
            employeeEntity.employeeId = employee.employeeId
            employeeEntity.name = employee.name
            employeeEntity.salary = employee.salary
            employeeEntity.age = employee.age
            employeeEntity.profileImage = employee.profileImage
        }

        do {
            try managedObjectContext.save()
        }
        catch let error {
            print("Could not save in core data: \(error.localizedDescription)")
        }
    }

    func retriveEmployees() -> [EmployeeEntity] {
        let managedObjectContext = persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
        let sortDescriptor1 = NSSortDescriptor(key: "employeeId", ascending: true)
        fetchRequest.sortDescriptors = [sortDescriptor1]
        var employeeEntities: [EmployeeEntity] = []
        do {
            employeeEntities = try managedObjectContext.fetch(fetchRequest)
        } catch let error {
            print(error)
        }
        return employeeEntities
    }

    func deleteEmployee(employeeEntity: EmployeeEntity) {
        let managedObjectContext = persistentContainer.viewContext
        managedObjectContext.delete(employeeEntity)

        do {
            try managedObjectContext.save()
        }
        catch let error {
            print("Could not delete from core data: \(error.localizedDescription)")
        }
    }
}
