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
            //print("cardviewawakefromnib")
            topViewHeight.constant = 0
            cardViewBottom.constant = 16
            cardView.layer.masksToBounds = true
            cardView.layer.cornerRadius = 10
            cardView.layer.borderWidth = 0.5
            cardView.layer.borderColor = UIColor.black.cgColor
        }
        

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
        //mainImageView.kf.setImage(with: url)
        //mainImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
        let halfScreenHeight = UIScreen.main.bounds.height / 2

        mainImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil) { (image, error, cache, url) in
//            let mainImageViewHeight = { () -> CGFloat in
//                let imageHeight = image?.cgImage?.height
//                let screenHeight = UIScreen.main.bounds.height / 2
//                return imageHeight == nil ? (screenHeight * 2) / 3 : CGFloat(imageHeight!) <= screenHeight ? CGFloat(imageHeight!) : screenHeight
//            }()
//            //self.imageHeightConstraint.constant = mainImageViewHeight
//           self.mainImageView.heightAnchor.constraint(equalToConstant: mainImageViewHeight).isActive = true
//            print(mainImageViewHeight, " hello")
            //print(url?.absoluteString)
        }
        mainImageView.heightAnchor.constraint(equalToConstant: halfScreenHeight).isActive = true
        //print("hi my dear")
//        mainImageView.sd_setShowActivityIndicatorView(true)
//        mainImageView.sd_setIndicatorStyle(.gray)
//        mainImageView.sd_setImage(with: url, placeholderImage: UIImage(named: ""), options: [SDWebImageOptions.progressiveDownload, SDWebImageOptions.allowInvalidSSLCertificates], progress: nil, completed: nil)
        subcategoryLabel.text = course.subcategory
        let logo_url = URL(string: course.logo_image_url)
        logoImageView.kf.setImage(with: logo_url)
        logoImageView.kf.setImage(with: logo_url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
        
    }
    
}
