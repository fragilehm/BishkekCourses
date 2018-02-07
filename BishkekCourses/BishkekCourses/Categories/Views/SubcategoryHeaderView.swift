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
        let imageView = UIImageView(image: #imageLiteral(resourceName: "coding").withRenderingMode(.alwaysOriginal))
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
    private let blurView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(backImageView)
        addSubview(blurView)
        addSubview(back)
        addSubview(titleLabel)
        blurView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        blurView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 16).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        var backButtonTopConstraint = 32
        if UIDevice().userInterfaceIdiom == .phone && UIScreen.main.nativeBounds.height == 2436{
            backButtonTopConstraint = 56
        }
        back.topAnchor.constraint(equalTo: self.topAnchor, constant: CGFloat(backButtonTopConstraint)).isActive = true
        back.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16).isActive = true
        backImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        backImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        backImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        backImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
