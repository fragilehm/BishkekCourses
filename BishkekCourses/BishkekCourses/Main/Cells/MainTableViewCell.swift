//
//  MainTableViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 1/20/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift
import Hero
class MainTableViewCell: UITableViewCell, UITextViewDelegate {
    @IBOutlet weak var mainImageView: UIImageView! {
        didSet {
            mainImageView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.contentMode = .left
            textView.textContainerInset = UIEdgeInsets.zero
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
            topViewHeight.constant = 0
            cardViewBottom.constant = 24
            cardView.layer.masksToBounds = true
            cardView.layer.cornerRadius = 10
        }
    }
    func fillCell(course: SimpleCourse){
        self.setMainData(course: course)
        self.setHeroId(course: course)
        self.setHashTagData(course: course)
    }
    func setMainData(course: SimpleCourse) {
        titleLabel.text = course.title
        decriptionLabel.text = course.description
        let url = URL(string: course.main_image_url)
        let halfScreenHeight = Constants.SCREEN_HEIGHT * 2 / 5
        mainImageView.kf.setImage(with: url, placeholder: Constants.PLACEHOLDER_IMAGE, options: [], progressBlock: nil) { (image, error, cache, url) in
        }
        let logo_url = URL(string: course.logo_image_url)
        logoImageView.kf.setImage(with: logo_url)
        logoImageView.kf.setImage(with: logo_url, placeholder: Constants.PLACEHOLDER_IMAGE, options: [], progressBlock: nil, completionHandler: nil)
        mainImageView.heightAnchor.constraint(equalToConstant: halfScreenHeight).isActive = true
    }
    func setHeroId(course: SimpleCourse) {
        mainImageView.heroID = "\(course.title)_image"
        mainImageView.heroModifiers = [.zPosition(2)]
        logoImageView.heroID = "\(course.title)_logo"
        logoImageView.heroModifiers = [.beginWith([.zPosition(5), .useGlobalCoordinateSpace])]
        titleLabel.heroID = "\(course.title)_name"
        titleLabel.heroModifiers = [.zPosition(10)]
    }
    func setHashTagData(course: SimpleCourse) {
        var subcategories = ""
        for simpleSubcategory in course.subcategories {
            subcategories.append("#")
            subcategories.append(simpleSubcategory.title)
        }
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineBreakMode = .byCharWrapping
        paragraph.alignment = .left
        let attributedString = NSMutableAttributedString(string: subcategories, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor: UIColor.black])
        let attr = NSMutableAttributedString(string: "Категори\(course.subcategories.count > 1 ? "и" : "я"): ", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 14), NSAttributedStringKey.paragraphStyle: paragraph])
        attr.append(attributedString)
        var indexCount = 11
        for simpleSubcategory in course.subcategories {
            let url = NSURL(string: "\(simpleSubcategory.id) \(simpleSubcategory.subcategory_image_url) \(simpleSubcategory.title)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            attr.addAttribute(.link, value: url ?? "", range: NSRange(location: indexCount, length: simpleSubcategory.title.count + 1))
            indexCount += simpleSubcategory.title.count + 1
        }
        let linkAttributes: [String : Any] = [
            NSAttributedStringKey.foregroundColor.rawValue: UIColor(netHex: Colors.HASHTAG)
        ]
        textView.linkTextAttributes = linkAttributes
        textView.attributedText = attr
    }
    
}
