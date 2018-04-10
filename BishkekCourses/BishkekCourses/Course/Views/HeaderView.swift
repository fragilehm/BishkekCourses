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
        label.text = "-"
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
        label.text = "-"
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
        setupMenuBar()
        setupLabelsAndImages()
        setupLines()
        self.bringSubview(toFront: logoImageView)
    }
    func setupMenuBar() {
        addSubview(menuBarView)
        NSLayoutConstraint.activate([
            menuBarView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            menuBarView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            menuBarView.heightAnchor.constraint(equalToConstant: 50)
            ])
        addSubview(lineView)
        NSLayoutConstraint.activate([
            lineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lineView.bottomAnchor.constraint(equalTo: menuBarView.topAnchor),
            lineView.heightAnchor.constraint(equalToConstant: 0.5)
            ])
    }
    func setupLabelsAndImages() {
        addSubview(raitingTitleLabel)
        addSubview(savesTitleLabel)
        addSubview(titleLabel)
        addSubview(logoImageView)
        NSLayoutConstraint.activate([
            titleLabel.bottomAnchor.constraint(equalTo: lineView.topAnchor, constant: -12),
            titleLabel.trailingAnchor.constraint(equalTo: savesTitleLabel.leadingAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: raitingTitleLabel.trailingAnchor),
            titleLabel.centerXAnchor.constraint(equalTo: logoImageView.centerXAnchor)
            ])
        NSLayoutConstraint.activate([
            logoImageView.bottomAnchor.constraint(equalTo: titleLabel.topAnchor, constant: -12),
            logoImageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.25),
            logoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: logoImageView.heightAnchor)
            ])
        NSLayoutConstraint.activate([
            raitingTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            raitingTitleLabel.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor),
            savesTitleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            savesTitleLabel.bottomAnchor.constraint(equalTo: logoImageView.bottomAnchor)
            ])
        addSubview(raitingValueLabel)
        addSubview(savesValueLabel)
        NSLayoutConstraint.activate([
            raitingValueLabel.centerXAnchor.constraint(equalTo: raitingTitleLabel.centerXAnchor),
            raitingValueLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor),
            savesValueLabel.centerXAnchor.constraint(equalTo: savesTitleLabel.centerXAnchor),
            savesValueLabel.topAnchor.constraint(equalTo: titleLabel.topAnchor)
            ])
        addSubview(mainImageView)
        NSLayoutConstraint.activate([
            mainImageView.topAnchor.constraint(equalTo: self.topAnchor),
            mainImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            mainImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            mainImageView.bottomAnchor.constraint(equalTo: logoImageView.topAnchor, constant: Constants.SCREEN_HEIGHT / 16)
            ])
    }
    func setupLines() {
        addSubview(lineView1)
        NSLayoutConstraint.activate([
            lineView1.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineView1.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lineView1.topAnchor.constraint(equalTo: mainImageView.bottomAnchor),
            lineView1.heightAnchor.constraint(equalToConstant: 0.5)
            ])
        addSubview(lineView2)
        NSLayoutConstraint.activate([
            lineView2.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            lineView2.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            lineView2.topAnchor.constraint(equalTo: menuBarView.bottomAnchor),
            lineView2.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lineView2.heightAnchor.constraint(equalToConstant: 0.5)
            ])
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
