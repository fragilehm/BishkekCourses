//
//  DepartmentTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 3/28/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class DepartmentTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func fillCell(department: Department) {
        titleLabel.text = department.title
        descriptionLabel.text = department.description
    }
}
