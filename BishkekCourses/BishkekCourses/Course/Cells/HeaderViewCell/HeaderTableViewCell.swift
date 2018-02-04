//
//  HeaderTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/6/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit
import Cosmos
protocol ButtonDelegate : class {
    func iconPressed(_ index: Int)
}
class HeaderTableViewCell: UITableViewCell {
    weak var cellDelegate: ButtonDelegate?

    @IBOutlet weak var logoImageView: UIImageView! {
        didSet {
            //logoImageView.layer.cornerRadius = 35
            logoImageView.layer.masksToBounds = true
            logoImageView.layer.borderWidth = 0.7
            logoImageView.layer.borderColor = UIColor.lightGray.cgColor
        }
    }
    @IBOutlet weak var logoImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var logoBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var backgroundImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var raitingLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var savesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionButton: UIButton!
    @IBOutlet weak var commentsButton: UIButton!
    @IBOutlet weak var locationsButton: UIButton!
    @IBOutlet weak var contactsButton: UIButton!
    @IBOutlet weak var servicesButton: UIButton!
    
    
    @IBAction func descriptionButtonPressed(_ sender: Any) {
        setSelectedButton(imageName: "description_selected", buttonIndex: 0, button: descriptionButton)
    }
    @IBAction func commentsButtonPressed(_ sender: Any) {
         setSelectedButton(imageName: "comments_selected", buttonIndex: 1, button: commentsButton)
    }
    @IBAction func locationsButtonPressed(_ sender: Any) {
         setSelectedButton(imageName: "locations_selected", buttonIndex: 2, button: locationsButton)
    }
    @IBAction func contactsButtonPressed(_ sender: Any) {
         setSelectedButton(imageName: "contacts_selected", buttonIndex: 3, button: contactsButton)
    }
    @IBAction func servicesButtonPressed(_ sender: Any) {
         setSelectedButton(imageName: "services_selected", buttonIndex: 4, button: servicesButton)
    }
//    @IBOutlet weak var starsView: CosmosView! {
//        didSet {
//            starsView.settings.starMargin = 15
//        }
//    }
    var selections = [true, false, false,
                      false, false]
    func resetSelected(index: Int){
        switch index {
        case 0:
            descriptionButton.setImage(UIImage(named: "description"), for: .normal)
        case 1:
            commentsButton.setImage(UIImage(named: "comments"), for: .normal)
        case 2:
            locationsButton.setImage(UIImage(named: "locations"), for: .normal)
        case 3:
            contactsButton.setImage(UIImage(named: "contacts"), for: .normal)
        default:
            servicesButton.setImage(UIImage(named: "services"), for: .normal)
        }
    }
    func setSelectedButton(imageName: String, buttonIndex: Int,button: UIButton){
        for (index, selection) in selections.enumerated() {
            if index != buttonIndex {
                if selection == true {
                    selections[buttonIndex] = true
                    selections[index] = false
                    resetSelected(index: index)
                    button.setImage(UIImage(named: imageName), for: .normal)
                    cellDelegate?.iconPressed(buttonIndex)
                    break
                }
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        let height = UIScreen.main.bounds.height
        let backgroundImageHeight = height / 3
        let logoImageHeight = backgroundImageHeight / 3
        let bottomConstraint = logoImageHeight / 2
        backgroundImageViewHeight.constant = backgroundImageHeight
        logoImageViewHeight.constant = logoImageHeight
        logoImageView.layer.cornerRadius = bottomConstraint
        logoBottomConstraint.constant = -bottomConstraint
        // Initialization code
    }

    func fillCell(course: SimpleCourse){
        nameLabel.text = course.title
        let logo_url = URL(string: course.logo_image_url)
        logoImageView.kf.setImage(with: logo_url)
        let background_url = URL(string: course.background_image_url)
        backgroundImageView.kf.setImage(with: background_url)
    }
    
}
