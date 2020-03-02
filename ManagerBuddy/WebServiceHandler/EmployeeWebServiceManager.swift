//
//  EmployeeWebServiceManager.swift
//  ManagerBuddy
//
//  Created by Amit Gajjar on 02/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import Foundation

class EmployeeWebServiceManager: WebServiceManager {

    // MARK: - EmployeeWebServiceManager Methods

    func fetchEmployees() {
        jsonData(forURLString: URLConstants.fetchEmployees, andMethod: .Get)
    }
    
    // MARK: - Parent class implementation methods

    override func parseData(withData data: Data) {
        if let jsonString = String(data: data, encoding: .utf8) {
           print(jsonString)
        }
    }

    override func parseError(withString errorString: String) {
        print(errorString)
    }
}
