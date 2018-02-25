//
//  StartingPageViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 1/19/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class StartingPageViewController: UIViewController {
    let mainImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "logo"))
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    let descriptionTextView: UITextView = {
        let textView = UITextView()
        
        let attributetText = NSMutableAttributedString(string: "Hello my dear friends", attributes: [NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 18)])
        attributetText.append(NSMutableAttributedString(string: "\n\n\nthis is my first practice to impalement constraints in ios programatically!", attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 13), NSAttributedStringKey.foregroundColor: UIColor.gray]))
        
        textView.attributedText = attributetText
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.isEditable = false
        textView.textAlignment = .center
        return textView
    }()
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        return button
    }()
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.red, for: .normal)
        return button
    }()
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = 4
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = .gray
        return pc
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(descriptionTextView)
        setupBottomControls()
        setupLayout()
    }
    fileprivate func setupBottomControls() {
        
        let bottomControlsStackView = UIStackView(arrangedSubviews: [previousButton, pageControl, nextButton])
        bottomControlsStackView.translatesAutoresizingMaskIntoConstraints = false
        bottomControlsStackView.distribution = .fillEqually
        bottomControlsStackView.axis = .horizontal
        view.addSubview(bottomControlsStackView)
        
        if #available(iOS 11.0, *) {
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor).isActive = true
        } else {
            bottomControlsStackView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            bottomControlsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            bottomControlsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        bottomControlsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomControlsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomControlsStackView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    func setupLayout() {
        let topContainerImageView: UIView = {
            let view = UIView()
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()
        view.addSubview(topContainerImageView)
        
        topContainerImageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        topContainerImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        topContainerImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topContainerImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topContainerImageView.addSubview(mainImageView)
        
        mainImageView.centerXAnchor.constraint(equalTo: topContainerImageView.centerXAnchor).isActive = true
        mainImageView.centerYAnchor.constraint(equalTo: topContainerImageView.centerYAnchor).isActive = true
        mainImageView.heightAnchor.constraint(equalTo: topContainerImageView.heightAnchor, multiplier: 0.5).isActive = true
        
        descriptionTextView.topAnchor.constraint(equalTo: topContainerImageView.bottomAnchor).isActive = true
        descriptionTextView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 24).isActive = true
        descriptionTextView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -24).isActive = true
        descriptionTextView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -24).isActive = true
    }
   
}
