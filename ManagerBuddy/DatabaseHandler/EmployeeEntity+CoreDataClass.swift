//
//  EmployeeEntity+CoreDataClass.swift
//  ManagerBuddy
//
//  Created by Amit Gajjar on 03/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//
//

import Foundation
import CoreData

@objc(EmployeeEntity)
public class EmployeeEntity: NSManagedObject {
    public func initials() -> String {
        var initials: String = StringConstants.empty
        if let nameArray = name?.components(separatedBy: " ") {
            for component in nameArray {
                initials = initials + component.prefix(1)
            }
        }
        return initials
    }
}
