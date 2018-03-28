//
//  HeaderView.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/7/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class HeaderView: UIView {
    let mainImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = Constants.SCREEN_HEIGHT / 16
        imageView.layer.masksToBounds = true
        imageView.layer.borderWidth = 0.7
        imageView.backgroundColor = .white
        imageView.layer.borderColor = UIColor.lightGray.cgColor
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let raitingTitleLabel: UILabel = {
       let label = UILabel()
        label.text = "Рейтинг"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let raitingValueLabel: UILabel = {
        let label = UILabel()
        label.text = "4.7"
        label.textColor = UIColor(netHex: Colors.LIGHT_BLUE)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let savesTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Сохранили"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let savesValueLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor(netHex: Colors.LIGHT_BLUE)
        label.text = "169"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "American University"
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()
    let menuBarView: MenuBar = {
        let menuBar = MenuBar()
        menuBar.translatesAutoresizingMaskIntoConstraints = false
        return menuBar
    }()
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(netHex: Colors.LINE_COLOR)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    let lineView1: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.groupTableViewBackground
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let lineView2: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(netHex: Colors.LINE_COLOR)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        addSubview(menuBarView)
        menuBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        menuBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        menuBarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        addSubview(lineView)
        lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        lineView.bottomAnchor.constraint(equalTo: menuBarView.topAnchor).isActive = true
        lineView.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        
//        titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
//        titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        
        addSubview(raitingTitleLabel)
        addSubview(savesTitleLabel)
        addSubview(titleLabel)
        //titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: -12).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: savesTitleLabel.leadingAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: raitingTitleLabel.trailingAnchor).isActive = true
        addSubview(logoImageView)
        logoImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -12).isActive = true
        logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25).isActive = true
        logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor).isActive = true
        raitingTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        raitingTitleLabel.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor).isActive = true
        savesTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        savesTitleLabel.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor).isActive = true
        addSubview(raitingValueLabel)
        raitingValueLabel.centerXAnchor.constraint(equalTo: raitingTitleLabel.centerXAnchor).isActive = true
        raitingValueLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        //raitingValueLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        addSubview(savesValueLabel)
        savesValueLabel.centerXAnchor.constraint(equalTo: savesTitleLabel.centerXAnchor).isActive = true
        //savesValueLabel.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor).isActive = true
        savesValueLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor).isActive = true
        //savesValueLabel.trailingAnchor.constraint(equalTo: savesTitleLabel.trailingAnchor).
        addSubview(mainImageView)
        mainImageView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        mainImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        mainImageView.bottomAnchor.constraint(equalTo: logoImageView.topAnchor, constant: Constants.SCREEN_HEIGHT / 16).isActive = true
        addSubview(lineView1)
        lineView1.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineView1.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        lineView1.topAnchor.constraint(equalTo: mainImageView.bottomAnchor).isActive = true
        lineView1.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        addSubview(lineView2)
        lineView2.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        lineView2.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        lineView2.topAnchor.constraint(equalTo: menuBarView.bottomAnchor).isActive = true
        lineView2.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        lineView2.heightAnchor.constraint(equalToConstant: 0.5).isActive = true
        self.bringSubview(toFront: logoImageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
