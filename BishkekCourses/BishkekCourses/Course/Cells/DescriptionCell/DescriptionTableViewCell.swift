//
//  DescriptionTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/6/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit

class DescriptionTableViewCell: CustomCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        //self.
        // Initialization code
    }
    func fillCell(description: String){
//        descriptionLabel.heroID = "course_decription"
//        descriptionLabel.heroModifiers = [.beginWith([.zPosition(15), .useGlobalCoordinateSpace])]
        descriptionLabel.text = description
    }
}
