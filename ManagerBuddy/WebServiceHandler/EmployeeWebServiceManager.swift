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
        do {
            guard let jsonResponseDictionary = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any], let employeesResponseArray = jsonResponseDictionary["data"] as? [[String: Any]]
                else {
                    parseError(withString: ErrorConstants.responseMismatched)
                    return
            }
            let employeesData: Data = try JSONSerialization.data(withJSONObject: employeesResponseArray, options: .prettyPrinted)
            let employees = try JSONDecoder().decode([Employee] .self, from: employeesData)
            delegate?.responseReceived(asObject: employees)
        }
        catch let error {
            parseError(withString: error.localizedDescription)
        }
    }

    override func parseError(withString errorString: String) {
        delegate?.errorReceived(withString: errorString)
    }
}
