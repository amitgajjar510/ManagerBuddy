//
//  EmployeeViewModel.swift
//  ManagerBuddy
//
//  Created by Amit Gajjar on 02/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import Foundation

class EmployeeViewModel {

    // MARK: - Properties
    var employeeEntities: [EmployeeEntity] = []
    private let databaseManager: DatabaseManager = DatabaseManager.shared
    private lazy var employeeWebServiceManager: EmployeeWebServiceManager = EmployeeWebServiceManager()

    func showEmployees() {
        // Get employees from Database first
        employeeEntities = databaseManager.retriveEmployees()
        // Call WebService Request
        fetchEmployees()
    }
}

extension EmployeeViewModel {

    func updateEmployeesAfterAPICall(withEmployees employees: [Employee]) {
        databaseManager.cleanUpEmployees()
        databaseManager.storeEmployees(withEmployees: employees)
    }
}

extension EmployeeViewModel: WebServiceManagerDelegate {

    // MARK: - API Calls

    private func fetchEmployees() {
        employeeWebServiceManager.delegate = self
        employeeWebServiceManager.fetchEmployees()
    }

    // MARK: - WebServiceManagerDelegate Methods

    func responseReceived(asObject object: Any) {
        guard let employees = object as? [Employee]
            else {
                errorReceived(withString: ErrorConstants.responseMismatched)
                return
        }
        updateEmployeesAfterAPICall(withEmployees: employees)
    }

    func errorReceived(withString errorString: String) {
        print(errorString)
    }
}
