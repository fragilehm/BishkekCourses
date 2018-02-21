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
    var action: Promotion!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarItems()
        //setSwipeLeftAction()
        courseNameLabel.text = action.course.title
        let url = URL(string: action.course.logo_image_url)
        courseLogoImageView.kf.setImage(with: url)
        actionTitleLabel.text = action.title
        actionDescriptionLabel.text = action.description
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+6:00") //Current time zone
        dateFormatter.locale = Locale.init(identifier: "en_US")
        let date = dateFormatter.date(from: action.end_date)
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let convertedDate = dateFormatter.string(from: date!)
        print(convertedDate)
        endDateLabel.text = convertedDate
        let backUrl = URL(string: action.action_image)
        backImageView.kf.setImage(with: backUrl)
        // Do any additional setup after loading the view.
    }
    @objc func openCourse(_ sender: UITapGestureRecognizer) {
        let course = action.course
        openCourse(id: course.id, name: course.title, logoUrl: course.logo_image_url, backUrl: course.main_image_url, description: course.description)
//        let courseVC = UIStoryboard.init(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "DetailedCourseViewController") as! DetailedCourseViewController
//        let course = action.course
//        courseVC.courseName = course.title
//        courseVC.courseBackImage = course.background_image_url
//        courseVC.courseLogo = course.logo_image_url
//        courseVC.course_id = course.id
//        self.navigationController?.show(courseVC, sender: self)
    }
    
    


}
