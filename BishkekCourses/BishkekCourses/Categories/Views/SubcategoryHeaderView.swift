//
//  SubcategoryHeaderView.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/7/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class SubcategoryHeaderView: UIView {
    let backImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let back: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        button.setImage(#imageLiteral(resourceName: "back-white").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    let actionCourseButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(#imageLiteral(resourceName: "more1").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    let blurView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 19, weight: .medium)
        label.textColor = .white
        label.textAlignment = .left
        label.numberOfLines = 0
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backImageView)
        addSubview(blurView)
        addSubview(back)
        addSubview(titleLabel)
        addSubview(actionCourseButton)
        NSLayoutConstraint.activate([
            blurView.topAnchor.constraint(equalTo: self.topAnchor),
            blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: blurView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: blurView.trailingAnchor, constant: -16),
            titleLabel.bottomAnchor.constraint(equalTo: blurView.bottomAnchor, constant: -16)
            ])
        var backButtonTopConstraint = 32
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436 {
            backButtonTopConstraint = 56
        }
        NSLayoutConstraint.activate([
            back.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(backButtonTopConstraint)),
            back.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            actionCourseButton.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(backButtonTopConstraint)),
            actionCourseButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            backImageView.topAnchor.constraint(equalTo: self.topAnchor),
            backImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            backImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            backImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor)
            ])
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
