//
//  StartingPageCollectionViewCell.swift
//  BishkekCourses
//
//  Created by Khasanza on 1/19/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
import UIKit

class StartingPageCollectionViewCell: UICollectionViewCell {
    
    var page: Page? {
        didSet {
            guard let unwrappedPage = page else {
                return
            }
            mainImageView.image = UIImage(named: unwrappedPage.imageName)
            let attributetText = NSMutableAttributedString(string: unwrappedPage.headerString, attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
            attributetText.append(NSMutableAttributedString(string: "\n\n\n\(unwrappedPage.bodyText)", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray]))
            descriptionTextView.attributedText = attributetText
            descriptionTextView.textAlignment = .center
        }
    }
    private let mainImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let descriptionTextView: UITextView = {
        let textView = UITextView()
        let attributetText = NSMutableAttributedString(string: "Hello my dear friends", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        attributetText.append(NSMutableAttributedString(string: "\n\n\nthis is my first practice to impalement constraints in ios programatically!", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributetText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.textAlignment = .center
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupLayout() {
        let topContainerImageView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        addSubview(topContainerImageView)
        
        topContainerImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5).isActive = true
        topContainerImageView.topAnchor.constraint(equalTo: topAnchor, constant: 0).isActive = true
        topContainerImageView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        topContainerImageView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        topContainerImageView.addSubview(mainImageView)
        
        mainImageView.centerXAnchor.constraint(equalTo: topContainerImageView.centerXAnchor).isActive = true
        mainImageView.centerYAnchor.constraint(equalTo: topContainerImageView.centerYAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalTo: topContainerImageView.heightAnchor, multiplier: 0.5).isActive = true
        addSubview(descriptionTextView)
        descriptionTextView.topAnchor.constraint(equalTo: topContainerImageView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -74).isActive = true
    }
    
}
