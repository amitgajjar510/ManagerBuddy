//
//  EmployeeViewModel.swift
//  ManagerBuddy
//
//  Created by Amit Gajjar on 02/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import Foundation

protocol EmployeeViewModelDelegate: class {
    func refreshEmployees()
    func error(withMessage message: String)
}

enum SortBy: String, CaseIterable {
    case SortByNameAscending = "Name: Ascending"
    case SortByNameDescending = "Name: Descending"
    case SortByAgeAscending = "Age: Ascending"
    case SortByAgeDescending = "Age: Descending"
}

class EmployeeViewModel {

    // MARK: - Properties
    var employeeEntities: [EmployeeEntity] = []
    private let databaseManager: DatabaseManager = DatabaseManager.shared
    private lazy var employeeWebServiceManager: EmployeeWebServiceManager = EmployeeWebServiceManager()
    weak var delegate: EmployeeViewModelDelegate?

    // MARK: - Public Methods

    func showEmployees() {
        if employeeEntities.count == 0 {
            // Get employees from Database first
            employeeEntities = databaseManager.retriveEmployees()
            // Call WebService Request
            fetchEmployees()
        }
    }

    func sortEmployee(sortBy: SortBy) {
        switch sortBy {
        case .SortByNameAscending:
            employeeEntities.sort { (employeeEntityOne, employeeEntityTwo) -> Bool in
                let employeeEntityOneName: String = employeeEntityOne.name ?? StringConstants.empty
                let employeeEntityTwoName: String = employeeEntityTwo.name ?? StringConstants.empty
                return employeeEntityOneName < employeeEntityTwoName
            }
        case .SortByNameDescending:
            employeeEntities.sort { (employeeEntityOne, employeeEntityTwo) -> Bool in
                let employeeEntityOneName: String = employeeEntityOne.name ?? StringConstants.empty
                let employeeEntityTwoName: String = employeeEntityTwo.name ?? StringConstants.empty
                return employeeEntityOneName > employeeEntityTwoName
            }
        case .SortByAgeAscending:
            employeeEntities.sort { (employeeEntityOne, employeeEntityTwo) -> Bool in
                let employeeEntityOneAge: String = employeeEntityOne.age ?? StringConstants.empty
                let employeeEntityTwoAge: String = employeeEntityTwo.age ?? StringConstants.empty
                return employeeEntityOneAge < employeeEntityTwoAge
            }
        case .SortByAgeDescending:
            employeeEntities.sort { (employeeEntityOne, employeeEntityTwo) -> Bool in
                let employeeEntityOneAge: String = employeeEntityOne.age ?? StringConstants.empty
                let employeeEntityTwoAge: String = employeeEntityTwo.age ?? StringConstants.empty
                return employeeEntityOneAge > employeeEntityTwoAge
            }
        }
        delegate?.refreshEmployees()
    }
}

extension EmployeeViewModel {

    // MARK: - Database Methods

    func updateEmployeesAfterAPICall(withEmployees employees: [Employee]) {
        databaseManager.cleanUpEmployees()
        databaseManager.storeEmployees(withEmployees: employees)
        employeeEntities = databaseManager.retriveEmployees()
        delegate?.refreshEmployees()
    }

    func deleteEmployee(atIndex index: Int) {
        let employeeEntity: EmployeeEntity = employeeEntities[index]
        databaseManager.deleteEmployee(employeeEntity: employeeEntity)
        employeeEntities = databaseManager.retriveEmployees()
        delegate?.refreshEmployees()
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
        delegate?.error(withMessage: errorString)
        delegate?.refreshEmployees()
    }
}
