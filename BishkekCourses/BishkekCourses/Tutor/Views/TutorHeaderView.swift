//
//  TutorHeaderView.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/22/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class TutorHeaderView: UIView {
    let headerBackImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        //image.image = #imageLiteral(resourceName: "lightGray").withRenderingMode(.alwaysOriginal)
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    let tutorImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.layer.cornerRadius = Constants.SCREEN_HEIGHT * 7 / 40
        image.image = #imageLiteral(resourceName: "coding").withRenderingMode(.alwaysOriginal)
        return image
    }()
    let nameLabel: UILabel = {
       let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        
        return label
    }()
    let experienceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        
        return label
    }()
    let priceLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 1
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    private let hiddenView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.groupTableViewBackground
        return view
    }()
    private let innerHiddenView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.clear
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(headerBackImageView)
        
        NSLayoutConstraint.activate([
            headerBackImageView.topAnchor.constraint(equalTo: self.topAnchor),
            headerBackImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            headerBackImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            headerBackImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
        self.addSubview(tutorImageView)
        tutorImageView.layer.masksToBounds = true
        NSLayoutConstraint.activate([
            tutorImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            tutorImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            tutorImageView.heightAnchor.constraint(equalTo: headerBackImageView.heightAnchor, multiplier: 0.7),
            tutorImageView.widthAnchor.constraint(equalTo: tutorImageView.heightAnchor, multiplier: 1)
            ])
        self.addSubview(nameLabel)
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: tutorImageView.bottomAnchor, constant: 16),
            nameLabel.leadingAnchor.constraint(equalTo: headerBackImageView.leadingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: headerBackImageView.trailingAnchor, constant: -12),
            nameLabel.bottomAnchor.constraint(equalTo: headerBackImageView.bottomAnchor, constant: -16)
            ])
//        addSubview(hiddenView)
//        NSLayoutConstraint.activate([
//            hiddenView.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 16),
//            hiddenView.leadingAnchor.constraint(equalTo: headerBackImageView.leadingAnchor, constant: 0),
//            hiddenView.trailingAnchor.constraint(equalTo: headerBackImageView.trailingAnchor, constant: 0),
//            hiddenView.bottomAnchor.constraint(equalTo: headerBackImageView.bottomAnchor, constant: 0),
//            hiddenView.heightAnchor.constraint(equalToConstant: 50)
//            ])
//        addSubview(experienceLabel)
//        NSLayoutConstraint.activate([
//            experienceLabel.leadingAnchor.constraint(equalTo: hiddenView.leadingAnchor, constant: 12),
//            experienceLabel.centerYAnchor.constraint(equalTo: hiddenView.centerYAnchor)
//            ])
//        addSubview(priceLabel)
//        NSLayoutConstraint.activate([
//            priceLabel.centerYAnchor.constraint(equalTo: experienceLabel.centerYAnchor),
//            priceLabel.leadingAnchor.constraint(equalTo: experienceLabel.trailingAnchor),
//            priceLabel.trailingAnchor.constraint(equalTo: hiddenView.trailingAnchor),
//            priceLabel.widthAnchor.constraint(equalTo: experienceLabel.widthAnchor, multiplier: 1)
//            ])
       

       
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
