//
//  Employee.swift
//  ManagerBuddy
//
//  Created by Amit Gajjar on 02/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import Foundation
import CoreData

class Employee: Codable {

    // MARK: - Properties

    var employeeId: String?
    var name: String?
    var salary: String?
    var age: String?
    var profileImage: String?

    // MARK: - Coding Keys enumerator

    private enum CodingKeys: String, CodingKey {
        case employeeId = "id"
        case name = "employee_name"
        case salary = "employee_salary"
        case age = "employee_age"
        case profileImage = "profile_image"
    }
}
