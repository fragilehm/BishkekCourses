//
//  SegmentView.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/8/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class SegmentView: UIView {
    let recentButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Недавние", for: .normal)
        button.isEnabled = false
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        return button
    }()
    let popularButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Популяпные", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(.lightGray, for: .normal)
        return button
    }()
    let bottomView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        return view
    }()
    let bottomLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .lightGray
        
        return view
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        addSubview(recentButton)
        addSubview(popularButton)
        addSubview(bottomView)
        addSubview(bottomLineView)
        NSLayoutConstraint.activate([
            recentButton.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            recentButton.trailingAnchor.constraint(equalTo: self.popularButton.leadingAnchor),
            recentButton.topAnchor.constraint(equalTo: self.topAnchor),
            recentButton.bottomAnchor.constraint(equalTo: bottomView.topAnchor),
            recentButton.widthAnchor.constraint(equalTo: popularButton.widthAnchor, multiplier: 1)
            ])
        NSLayoutConstraint.activate([
            popularButton.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            popularButton.topAnchor.constraint(equalTo: self.topAnchor),
            popularButton.bottomAnchor.constraint(equalTo: bottomView.topAnchor)
            ])
        NSLayoutConstraint.activate([
            bottomView.heightAnchor.constraint(equalToConstant: 1),
            bottomView.widthAnchor.constraint(equalToConstant: Constants.SCREEN_WIDTH / 2),
            bottomView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomView.bottomAnchor.constraint(equalTo: self.bottomLineView.topAnchor)
            ])
        NSLayoutConstraint.activate([
            bottomLineView.heightAnchor.constraint(equalToConstant: 0.7),
            bottomLineView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            bottomLineView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            bottomLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0.7)
            ])

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
