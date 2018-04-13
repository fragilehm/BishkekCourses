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
    @IBOutlet weak var newsDescriptionLabel: UILabel!
    @IBOutlet weak var newsAddDateLabel: UILabel!
    var news: News!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarItems()
        fillData()
    }
    func fillData() {
        newsTitleLabel.text = news.title
        newsDescriptionLabel.text = news.description
        newsAddDateLabel.text = news.added?.getConvertedDate()
        let backUrl = URL(string: news.news_image)
        backImageView.kf.setImage(with: backUrl, placeholder: Constants.PLACEHOLDER_IMAGE, options: nil, progressBlock: nil, completionHandler: nil)
    }
}


