//
//  GrantDetailViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 4/13/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class GrantDetailViewController: UIViewController {
    
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
    @IBOutlet weak var imageHeightConstraint: NSLayoutConstraint!

    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var grantTitleLabel: UILabel!
    @IBOutlet weak var grantDescriptionTextView: UITextView!
    var universityHeader: CourseHeader!
    var isFromCourse = false
    var simpleGrant: SimpleGrant!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarItems()
        fillData()
    }
    func fillData() {
        courseNameLabel.text = universityHeader.title
        let url = URL(string: universityHeader.logo_image_url)
        courseLogoImageView.kf.setImage(with: url)
        grantTitleLabel.text = simpleGrant.title
        grantDescriptionTextView.text = simpleGrant.description
        let backUrl = URL(string: simpleGrant.grant_image)
        backImageView.kf.setImage(with: backUrl, placeholder: Constants.PLACEHOLDER_IMAGE, options: nil, progressBlock: nil) { (image, error, cache, url) in
            let ratio = Constants.SCREEN_WIDTH / CGFloat((image?.cgImage?.width)!)
            let height = CGFloat((image?.cgImage?.height)!) * ratio
            self.imageHeightConstraint.constant = height
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    @objc func openCourse(_ sender: UITapGestureRecognizer) {
        self.navigationController?.popViewController(animated: false)
    }
}

