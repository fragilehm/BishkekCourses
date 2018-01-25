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
            logoImageView.layer.borderWidth = 0.7
            logoImageView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var mainImageView: UIImageView!
//    @IBOutlet weak var startsView: CosmosView! {
//        didSet {
//            startsView.settings.updateOnTouch = false
//            startsView.settings.starMargin = 2
//        }
//    }
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        cardView.layer.cornerRadius = 5
        cardView.layer.masksToBounds = true
        // Initialization code
    }
    func fillCell(course: SimplifiedCourse){
        titleLabel.text = course.title
        descriptionLabel.text = course.description
        let logo_url = URL(string: course.logo_image_url)
       
        //logoImageView.kf.setImage(with: logo_url)
        logoImageView.kf.setImage(with: logo_url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
        let background_url = URL(string: course.background_image_url)
        //mainImageView.kf.setImage(with: background_url)
        mainImageView.kf.setImage(with: background_url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
    }
}
