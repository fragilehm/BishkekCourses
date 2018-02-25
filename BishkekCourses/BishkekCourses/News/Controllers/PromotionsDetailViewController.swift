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
        //getDetailAction()
        // Do any additional setup after loading the view.
    }
//    func getDetailAction(){
//        ServerAPIManager.sharedAPI.getDetailedAction(action_id: actionId, setAction, showError: showErrorAlert)
//    }
//    func setAction(action: Promotion){
//        detailedAction = action
//        fillData()
//    }
    func fillData() {
        courseNameLabel.text = courseHeader.title
        let url = URL(string: courseHeader.logo_image_url)
        courseLogoImageView.kf.setImage(with: url)
        actionTitleLabel.text = simpleAction.title
        actionDescriptionLabel.text = simpleAction.description
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+6:00") //Current time zone
        dateFormatter.locale = Locale.init(identifier: "en_US")
        let date = dateFormatter.date(from: simpleAction.end_date)
        dateFormatter.dateFormat = "dd MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        let convertedDate = dateFormatter.string(from: date!)
        endDateLabel.text = convertedDate
        let backUrl = URL(string: simpleAction.action_image)
        backImageView.kf.setImage(with: backUrl)
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
