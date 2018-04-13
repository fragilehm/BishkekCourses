//
//  GrantTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 4/13/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class GrantTableViewCell: UITableViewCell {
    
    @IBOutlet weak var grantTitleLabel: UILabel!
    @IBOutlet weak var grantDescriptionLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView! {
        didSet {
            backImageView.layer.borderWidth = 0.7
            backImageView.layer.borderColor = UIColor(netHex: Colors.LINE_COLOR).cgColor
            backImageView.contentMode = .scaleAspectFill
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func fillCell(action: SimpleGrant) {
        grantTitleLabel.text = action.title
        grantDescriptionLabel.text = action.description
        let backUrl = URL(string: action.grant_image)
        backImageView.kf.setImage(with: backUrl, placeholder: Constants.PLACEHOLDER_IMAGE, options: nil, progressBlock: nil, completionHandler: nil)
    }
}
