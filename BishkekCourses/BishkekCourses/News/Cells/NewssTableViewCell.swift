//
//  NewssTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 4/13/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//
import UIKit

class NewssTableViewCell: UITableViewCell {
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsEndDateLabel: UILabel!
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
    func fillCell(news: News) {
        newsTitleLabel.text = news.title
        newsDescriptionLabel.text = news.description
        let backUrl = URL(string: news.news_image)
        newsEndDateLabel.text = news.added?.getConvertedDate()
        backImageView.kf.setImage(with: backUrl, placeholder: Constants.PLACEHOLDER_IMAGE, options: nil, progressBlock: nil, completionHandler: nil)
    }
}
