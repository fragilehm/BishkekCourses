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

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var mainImageView: UIImageView! {
        didSet {
            //            mainImageView.layer.masksToBounds = true
            //            mainImageView.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var logoImageView: UIImageView! {
        didSet {
            logoImageView.layer.masksToBounds = true
            logoImageView.layer.cornerRadius = 20
        }
    }
    @IBOutlet weak var subcategoryLabel: UILabel!
    @IBOutlet weak var decriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardView: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func fillCell(course: SimplifiedCourse){
        titleLabel.text = course.title
        decriptionLabel.text = course.description
        let url = URL(string: course.main_image_url)
        mainImageView.kf.setImage(with: url)
        
//        mainImageView.sd_setShowActivityIndicatorView(true)
//        mainImageView.sd_setIndicatorStyle(.gray)
//        mainImageView.sd_setImage(with: url, placeholderImage: UIImage(named: ""), options: [SDWebImageOptions.progressiveDownload, SDWebImageOptions.allowInvalidSSLCertificates], progress: nil, completed: nil)
        subcategoryLabel.text = course.subcategory
        let logo_url = URL(string: course.logo_image_url)
        logoImageView.kf.setImage(with: logo_url)
    }
    
}
