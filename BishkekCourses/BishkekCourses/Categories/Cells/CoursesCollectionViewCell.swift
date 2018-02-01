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
            var logoHeight = ((UIScreen.main.bounds.width - 12) * 2) / 15

            if UIDevice.current.userInterfaceIdiom == .pad {
                logoHeight = (((4 * UIScreen.main.bounds.width / 5) - 24) * 2) / 15

            }
            //print(logoHeight)
            logoImageView.layer.cornerRadius = logoHeight / 2
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
        //print(logoImageView.frame.height, " dsdskdks")
        cardView.layer.cornerRadius = 10
        cardView.layer.masksToBounds = true
        // Initialization code
    }
    func fillCell(course: SimpleCourse){
        titleLabel.text = course.title
        descriptionLabel.text = course.description
        let logo_url = URL(string: course.logo_image_url)
        //print(logoImageView.frame.height, " dsdskdkssdsdsdsdsds")
        //logoImageView.kf.setImage(with: logo_url)
        logoImageView.kf.setImage(with: logo_url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
        let background_url = URL(string: course.background_image_url)
        //mainImageView.kf.setImage(with: background_url)
        mainImageView.kf.setImage(with: background_url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
    }
}
