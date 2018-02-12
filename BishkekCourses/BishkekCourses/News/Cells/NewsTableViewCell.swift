//
//  NewsTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/9/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var courseLogoImageView: UIImageView! {
        didSet {
            courseLogoImageView.layer.borderWidth = 0.5
            courseLogoImageView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var courseTitleLabel: UILabel!
    @IBOutlet weak var promotionsTitleLabel: UILabel!
    @IBOutlet weak var promotionsDescriptionLabel: UILabel!
    @IBOutlet weak var promotionsEndDateLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var topViewheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardViewTopConstraint: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        let labelHeight = promotionsTitleLabel.frame.height + 8 + promotionsDescriptionLabel.frame.height
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backImageView.widthAnchor.constraint(equalTo: backImageView.heightAnchor, multiplier: 1)
//        backImageView.heightAnchor.constraint(equalToConstant: labelHeight + 4).isActive = true
        // Initialization code
        if UIDevice.current.userInterfaceIdiom == .pad {
            topViewheightConstraint.constant = 0
            cardViewTopConstraint.constant = 24
            cardView.layer.masksToBounds = true
            cardView.layer.cornerRadius = 10
        }
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
