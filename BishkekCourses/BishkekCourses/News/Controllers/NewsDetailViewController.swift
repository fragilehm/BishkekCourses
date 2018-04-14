//
//  NewsDetailViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 4/13/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class NewsDetailViewController: UIViewController {

    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var newsTitleLabel: UILabel!
    @IBOutlet weak var newsAddDateLabel: UILabel!
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var news: News!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarItems()
        fillData()
    }
    func fillData() {
        newsTitleLabel.text = news.title
        descriptionTextView.text = news.description
        newsAddDateLabel.text = news.added?.getConvertedDate()
        let backUrl = URL(string: news.news_image)
        backImageView.kf.setImage(with: backUrl, placeholder: Constants.PLACEHOLDER_IMAGE, options: nil, progressBlock: nil) { (image, error, cache, url) in
            let ratio = Constants.SCREEN_WIDTH / CGFloat((image?.cgImage?.width)!)
            let height = CGFloat((image?.cgImage?.height)!) * ratio
            self.imageHeightConstraint.constant = height
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
            print(height)
        }
        
    }
}


