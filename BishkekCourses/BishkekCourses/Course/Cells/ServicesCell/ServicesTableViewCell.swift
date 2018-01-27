//
//  ServicesTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/6/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit

class ServicesTableViewCell: CustomCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func fillCell(service: Service){
        titleLabel.text = service.title
        descriptionLabel.text = service.description
        priceLabel.text = "\(service.price)"
    }
}
