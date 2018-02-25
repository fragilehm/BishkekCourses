//
//  CourseActionTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/24/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class CourseActionTableViewCell: UITableViewCell {

    @IBOutlet weak var promotionsTitleLabel: UILabel!
    @IBOutlet weak var promotionsDescriptionLabel: UILabel!
    @IBOutlet weak var promotionsEndDateLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView! {
        didSet {
            backImageView.layer.borderWidth = 0.7
            backImageView.layer.borderColor = UIColor(netHex: Colors.LINE_COLOR).cgColor
            backImageView.contentMode = .scaleAspectFill
        }
    }
    //    @IBOutlet weak var topViewheightConstraint: NSLayoutConstraint!
    //    @IBOutlet weak var cardViewTopConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        //        let labelHeight = promotionsTitleLabel.frame.height + 8 + promotionsDescriptionLabel.frame.height
        //        backImageView.translatesAutoresizingMaskIntoConstraints = false
        //        backImageView.widthAnchor.constraint(equalTo: backImageView.heightAnchor, multiplier: 1)
        //        backImageView.heightAnchor.constraint(equalToConstant: labelHeight + 4).isActive = true
        // Initialization code
        //        if UIDevice.current.userInterfaceIdiom == .pad {
        //            topViewheightConstraint.constant = 0
        //        }
        // Initialization code
    }
    func fillCell(action: SimplePromotion) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+6:00") //Current time zone
        let date = dateFormatter.date(from: action.end_date)
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let convertedDate = dateFormatter.string(from: date!)
        promotionsTitleLabel.text = action.title
        promotionsDescriptionLabel.text = action.description
        promotionsEndDateLabel.text = convertedDate
        let backUrl = URL(string: action.action_image)
        backImageView.kf.setImage(with: backUrl)
    }
}
