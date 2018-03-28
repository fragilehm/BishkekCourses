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
    func fillCell(title: String, description: String, logo_image_url: String, main_image_url: String) {
        titleLabel.text = title
        titleLabel.heroID = "\(title)_name"
        titleLabel.heroModifiers = [.beginWith([.zPosition(10), .useGlobalCoordinateSpace])]
        let logoUrl = URL(string: logo_image_url)
        logoImageView.heroID = "\(title)_logo"
        logoImageView.heroModifiers = [.beginWith([.zPosition(5), .useGlobalCoordinateSpace])]
        logoImageView.kf.setImage(with: logoUrl, placeholder: Constants.PLACEHOLDER_IMAGE, options: [], progressBlock: nil, completionHandler: nil)
        let backUrl = URL(string: main_image_url)
        backImageView.heroID = "\(title)_image"
        backImageView.heroModifiers = [.zPosition(2)]
        backImageView.kf.setImage(with: backUrl, placeholder: Constants.PLACEHOLDER_IMAGE, options: [], progressBlock: nil, completionHandler: nil)
        descriptionLabel.text = description
    }
}
