//
//  CoursesBySubcategoryTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/3/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class CoursesBySubcategoryTableViewCell: CustomCell {

    @IBOutlet weak var logoImageView: UIImageView! {
        didSet {
            logoImageView.layer.borderWidth = 0.5
            logoImageView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var topViewheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
//        let labelHeight = descriptionLabel.frame.height
//        backImageView.translatesAutoresizingMaskIntoConstraints = false
//        backImageView.heightAnchor.constraint(equalToConstant: labelHeight + 4).isActive = true
        // Initialization code
        if UIDevice.current.userInterfaceIdiom == .pad {
            topViewheightConstraint.constant = 0
            cardViewTopConstraint.constant = 24
            cardView.layer.masksToBounds = true
            cardView.layer.cornerRadius = 10
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func fillCell(course: SimpleCourse){
        titleLabel.text = course.title
        let logoUrl = URL(string: course.logo_image_url)
        logoImageView.kf.setImage(with: logoUrl, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
        let backUrl = URL(string: course.background_image_url)
        backImageView.kf.setImage(with: backUrl, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
        descriptionLabel.text = course.description
        //subCategoriesImageView.kf.setImage(with: url)
    }
}
