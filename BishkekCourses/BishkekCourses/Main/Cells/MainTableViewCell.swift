//
//  MainTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 1/20/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
import Kingfisher
import SDWebImage
import RxSwift
class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView! {
        didSet {
            mainImageView.translatesAutoresizingMaskIntoConstraints = false
            //print(mainImageView.frame.height)
        }
    }
    @IBOutlet weak var topViewHeight: NSLayoutConstraint!
    @IBOutlet weak var cardViewBottom: NSLayoutConstraint!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var logoImageView: UIImageView! {
        didSet {
            
            logoImageView.layer.masksToBounds = true
            logoImageView.layer.cornerRadius = 20
            logoImageView.layer.borderWidth = 0.7
            logoImageView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var subcategoryLabel: UILabel!
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.current.userInterfaceIdiom == .pad {
            topViewHeight.constant = 0
            cardViewBottom.constant = 24
            cardView.layer.masksToBounds = true
            cardView.layer.cornerRadius = 10
        }
        

        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func fillCell(course: SimpleCourse){
        titleLabel.text = course.title
        decriptionLabel.text = course.description
        let url = URL(string: course.main_image_url)
        let halfScreenHeight = Constants.SCREEN_HEIGHT / 2
        mainImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil) { (image, error, cache, url) in
        }
        mainImageView.heightAnchor.constraint(equalToConstant: halfScreenHeight).isActive = true
        var subcategories = ""
        let last_index = course.subcategories.count
        for (index, simpleSubcategory) in course.subcategories.enumerated() {
            subcategories.append(simpleSubcategory.title)
            if index < last_index - 1 {
                subcategories.append(", ")
            }
        }
        subcategoryLabel.text = subcategories
        let logo_url = URL(string: course.logo_image_url)
        logoImageView.kf.setImage(with: logo_url)
        logoImageView.kf.setImage(with: logo_url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
    }
    
}
