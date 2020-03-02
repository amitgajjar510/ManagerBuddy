//
//  EmployeeTableCell.swift
//  ManagerBuddy
//
//  Created by Amit Gajjar on 03/03/20.
//  Copyright © 2020 amitgajjar. All rights reserved.
//

import UIKit

class EmployeeTableCell: UITableViewCell {

    // MARK: - Properties & Outlets
    @IBOutlet weak var imageContentView: UIView!
    @IBOutlet weak var initialsLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!

    // MARK: - View Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    // MARK: - Public Methods
    func fillCellData(forTag tag: Int, withEmployeeEntity employeeEntity: EmployeeEntity) {
        self.tag = tag
        initialsLabel.text = employeeEntity.initials()
        nameLabel.text = employeeEntity.name
    }
}
