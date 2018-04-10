//
//  PromotionsDetailViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/10/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class PromotionsDetailViewController: UIViewController {

    @IBOutlet weak var courseLogoImageView: UIImageView! {
        didSet {
            courseLogoImageView.layer.borderWidth = 0.5
            courseLogoImageView.layer.borderColor = UIColor.lightGray.cgColor
            courseLogoImageView.contentMode = .scaleAspectFill
            courseLogoImageView.layer.masksToBounds = true
            courseLogoImageView.layer.cornerRadius = 17.5
            courseLogoImageView.isUserInteractionEnabled = true
            let titleGesture = UITapGestureRecognizer(target: self, action: #selector(openCourse(_:)))
            titleGesture.numberOfTapsRequired = 1
            courseLogoImageView.addGestureRecognizer(titleGesture)
            
        }
    }
    @IBOutlet weak var courseNameLabel: UILabel! {
        didSet {
            courseNameLabel.isUserInteractionEnabled = true
            let titleGesture = UITapGestureRecognizer(target: self, action: #selector(openCourse(_:)))
            titleGesture.numberOfTapsRequired = 1
            courseNameLabel.addGestureRecognizer(titleGesture)
        }
    }
    @IBOutlet weak var endDateLabel: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var actionTitleLabel: UILabel!
    @IBOutlet weak var actionDescriptionLabel: UILabel!
    var isFromCourse = false
    var courseHeader: CourseHeader!
    var simpleAction: SimplePromotion!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarItems()
        fillData()
    }
    func fillData() {
        courseNameLabel.text = courseHeader.title
        let url = URL(string: courseHeader.logo_image_url)
        courseLogoImageView.kf.setImage(with: url)
        actionTitleLabel.text = simpleAction.title
        actionDescriptionLabel.text = simpleAction.description
        endDateLabel.text = simpleAction.end_date.getConvertedDate()
        let backUrl = URL(string: simpleAction.action_image)
        backImageView.kf.setImage(with: backUrl, placeholder: Constants.PLACEHOLDER_IMAGE, options: nil, progressBlock: nil, completionHandler: nil)
    }
    @objc func openCourse(_ sender: UITapGestureRecognizer) {
        if isFromCourse {
            self.navigationController?.popViewController(animated: false)
        }
        else {
             openCourse(id: courseHeader.id, name: courseHeader.title, logoUrl: courseHeader.logo_image_url, backUrl: courseHeader.main_image_url, description: courseHeader.description)
        }
    }
}
