//
//  EmployeeDetailViewController.swift
//  ManagerBuddy
//
//  Created by Amit Gajjar on 03/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import UIKit

class EmployeeDetailViewController: UIViewController {

    // MARK: - Properties & Outlets
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var salaryLabel: UILabel!

    var employeeEntity: EmployeeEntity?

    // MARK: View Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }

    // MARK: - Private Methods

    private func initializeView() {
        title = employeeEntity?.name
        initialsLabel.text = employeeEntity?.initials()
        ageLabel.text = "Age    :   " + (employeeEntity?.age ?? StringConstants.empty)
        salaryLabel.text = "Salary  :   " + (employeeEntity?.salary ?? StringConstants.empty)
    }
}
