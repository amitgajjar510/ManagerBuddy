//
//  EmployeeViewController.swift
//  ManagerBuddy
//
//  Created by Amit Gajjar on 03/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import UIKit

class EmployeeViewController: UIViewController {

    // MARK: - Properties & Outlets
    @IBOutlet weak var employeeTableView: UITableView!

    private var employeeViewModel: EmployeeViewModel = EmployeeViewModel()

    // MARK: - View Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        initializeView()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        employeeViewModel.showEmployees()
    }

    // MARK: - Action Methods
    @IBAction func sortByButtonClicked(_ sender: UIBarButtonItem) {
        openSortByAlertController()
    }

    // MARK: - Private Methods

    private func initializeView() {
        title = StringConstants.ScreenTitles.Employee.rawValue
        employeeTableView.tableFooterView = UIView()
        employeeTableView.register(UINib(nibName: "EmployeeTableCell", bundle: nil), forCellReuseIdentifier: "EmployeeTableCell")

        employeeViewModel.delegate = self
    }

    private func openSortByAlertController() {
        let alertController: UIAlertController = UIAlertController(title: "Sort By", message: nil, preferredStyle: .actionSheet)
        SortBy.allCases.forEach { [weak self] (sortBy) in
            let alertAction: UIAlertAction = UIAlertAction(title: sortBy.rawValue, style: .default) { (alertAction) in
                self?.employeeViewModel.sortEmployee(sortBy: sortBy)
            }
            alertController.addAction(alertAction)
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(cancelAction)
        DispatchQueue.main.async { [weak self] in
            self?.present(alertController, animated: true, completion: nil)
        }
    }
}

extension EmployeeViewController: EmployeeViewModelDelegate {

    // MARK: - EmployeeViewModelDelegate Methods

    func refreshEmployees() {
        DispatchQueue.main.async { [weak self] in
            self?.employeeTableView.reloadData()
        }
    }
}

extension EmployeeViewController: UITableViewDataSource, UITableViewDelegate {

    // MARK: - UITableViewDataSource Methods

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return employeeViewModel.employeeEntities.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EmployeeTableCell", for: indexPath)
        let employeeEntity: EmployeeEntity = employeeViewModel.employeeEntities[indexPath.row]
        (cell as? EmployeeTableCell)?.fillCellData(forTag: indexPath.row, withEmployeeEntity: employeeEntity)
        return cell
    }

    // MARK: - UITableViewDelegate Methods

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let employeeDetailViewController: EmployeeDetailViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "EmployeeDetailViewController") as? EmployeeDetailViewController {
            let employeeEntity: EmployeeEntity = employeeViewModel.employeeEntities[indexPath.row]
            employeeDetailViewController.employeeEntity = employeeEntity
            navigationController?.pushViewController(employeeDetailViewController, animated: true)
        }
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            employeeViewModel.deleteEmployee(atIndex: indexPath.row)
        }
    }
}
