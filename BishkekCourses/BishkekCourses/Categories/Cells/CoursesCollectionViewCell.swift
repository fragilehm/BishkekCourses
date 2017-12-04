//
//  CoursesCollectionViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/4/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit
import Cosmos
class CoursesCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var logoImageView: UIImageView! {
        didSet {
            logoImageView.layer.cornerRadius = 30
            logoImageView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var startsView: CosmosView! {
        didSet {
            startsView.settings.updateOnTouch = false
            startsView.settings.starMargin = 2
        }
    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 5
        cardView.layer.masksToBounds = true
        // Initialization code
    }

}
