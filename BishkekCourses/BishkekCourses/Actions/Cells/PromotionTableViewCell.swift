//
//  PromotionTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 4/13/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
protocol ActionsTableViewCellDelegate : class {
    func ActionsTableViewCellDidTapCourse(_ row: Int)
}
class PromotionTableViewCell: UITableViewCell {
    weak var delegate: ActionsTableViewCellDelegate?
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var courseLogoImageView: UIImageView! {
        didSet {
            courseLogoImageView.layer.borderWidth = 0.5
            courseLogoImageView.layer.borderColor = UIColor.lightGray.cgColor
            courseLogoImageView.isUserInteractionEnabled = true
            let titleGesture = UITapGestureRecognizer(target: self, action: #selector(openCourse(_:)))
            titleGesture.numberOfTapsRequired = 1
            courseLogoImageView.addGestureRecognizer(titleGesture)
        }
    }
    @IBOutlet weak var courseTitleLabel: UILabel! {
        didSet {
            courseTitleLabel.isUserInteractionEnabled = true
            let titleGesture = UITapGestureRecognizer(target: self, action: #selector(openCourse(_:)))
            titleGesture.numberOfTapsRequired = 1
            courseTitleLabel.addGestureRecognizer(titleGesture)
        }
    }
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
    @IBOutlet weak var topViewheightConstraint: NSLayoutConstraint!
    @IBOutlet weak var cardViewTopConstraint: NSLayoutConstraint!
    private var cellIndex: Int?
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
        
    }
    func fillCell(action: Promotion, index: Int) {
        cellIndex = index
        courseTitleLabel.text = action.course.title
        let url = URL(string: action.course.logo_image_url)
        courseLogoImageView.kf.setImage(with: url)
        promotionsTitleLabel.text = action.title
        promotionsDescriptionLabel.text = action.description
        promotionsEndDateLabel.text = action.end_date?.getConvertedDate()
        let backUrl = URL(string: action.action_image)
        backImageView.kf.setImage(with: backUrl, placeholder: Constants.PLACEHOLDER_IMAGE, options: nil, progressBlock: nil, completionHandler: nil)
    }
    @objc func openCourse(_ sender: UITapGestureRecognizer) {
        delegate?.ActionsTableViewCellDidTapCourse(cellIndex!)
    }
}

