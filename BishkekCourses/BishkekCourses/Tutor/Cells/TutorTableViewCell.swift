//
//  TutorTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/22/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class TutorTableViewCell: UITableViewCell {

    @IBOutlet weak var tutorImage: UIImageView!
    @IBOutlet weak var tutorNameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var experienceLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func fillCell(tutor: Tutor) {
        let tutorUrl = URL(string: tutor.tutor_image)
        tutorImage.kf.setImage(with: tutorUrl)
        tutorNameLabel.text = tutor.name
        descriptionLabel.text = tutor.description
        experienceLabel.text = tutor.start_date.getExperience()
        priceLabel.text = tutor.price
    }
    
}

