//
//  EmployeeEntity+CoreDataProperties.swift
//  ManagerBuddy
//
//  Created by Amit Gajjar on 03/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//
//

import Foundation
import CoreData


extension EmployeeEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<EmployeeEntity> {
        return NSFetchRequest<EmployeeEntity>(entityName: "EmployeeEntity")
    }

    @NSManaged public var employeeId: String?
    @NSManaged public var name: String?
    @NSManaged public var salary: String?
    @NSManaged public var age: String?
    @NSManaged public var profileImage: String?

}
