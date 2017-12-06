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
            logoImageView.layer.cornerRadius = 35
            logoImageView.layer.masksToBounds = true
            logoImageView.layer.borderWidth = 2
            logoImageView.layer.borderColor = UIColor.white.cgColor
        }
    }
    @IBOutlet weak var raitingLabel: UILabel!
    @IBOutlet weak var savesLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var starsView: CosmosView! {
        didSet {
            starsView.settings.starMargin = 15
        }
    }
    var selections = [true, false, false,
                      false, false]
    @IBOutlet weak var descriptionImageView: UIImageView! {
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(descriptionTapped(tapGestureRecognizer:)))
            descriptionImageView.isUserInteractionEnabled = true
            descriptionImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @objc func descriptionTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        setSelected(imageName: "description_selected", imageIndex: 0, image: descriptionImageView)
    }
    @IBOutlet weak var commentsImageView: UIImageView!{
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(commentsTapped(tapGestureRecognizer:)))
            commentsImageView.isUserInteractionEnabled = true
            commentsImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @objc func commentsTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        setSelected(imageName: "comments_selected", imageIndex: 1, image: commentsImageView)
    }
    @IBOutlet weak var locationsImageView: UIImageView!{
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(locationsTapped(tapGestureRecognizer:)))
            locationsImageView.isUserInteractionEnabled = true
            locationsImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @objc func locationsTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        setSelected(imageName: "locations_selected", imageIndex: 2, image: locationsImageView)
    }
    @IBOutlet weak var contactsImageView: UIImageView!{
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(contactsTapped(tapGestureRecognizer:)))
            contactsImageView.isUserInteractionEnabled = true
            contactsImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @objc func contactsTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        setSelected(imageName: "contacts_selected", imageIndex: 3, image: contactsImageView)
    }
    @IBOutlet weak var servicesImageView: UIImageView!{
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(servicesTapped(tapGestureRecognizer:)))
            servicesImageView.isUserInteractionEnabled = true
            servicesImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @objc func servicesTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        setSelected(imageName: "services_selected", imageIndex: 4, image: servicesImageView)
    }
    func resetSelected(){
        if selections[0] == false {
            descriptionImageView.image = UIImage(named: "description")
        }
        if selections[1] == false {
            commentsImageView.image = UIImage(named: "comments")
        }
        if selections[2] == false {
            locationsImageView.image = UIImage(named: "locations")
        }
        if selections[3] == false{
            contactsImageView.image = UIImage(named: "contacts")
        }
        if selections[4] == false{
            servicesImageView.image = UIImage(named: "services")
        }
    }
    func setSelected(imageName: String, imageIndex: Int,image: UIImageView){
        for (index, selection) in selections.enumerated() {
            if index != imageIndex {
                if selection == true {
                    selections[imageIndex] = true
                    selections[index] = false
                    resetSelected()
                    image.image = UIImage(named: imageName)
                    cellDelegate?.iconPressed(imageIndex)
                    break
                }
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
