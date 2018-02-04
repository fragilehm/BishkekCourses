//
//  SwipingControllers.swift
//  BishkekCourses
//
//  Created by Khasanza on 1/19/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class SwipingController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    
    let pages = [
        Page(imageName: "logo", headerString: "Hello my dear friends", bodyText: "interesting text"),
        Page(imageName: "cat", headerString: "subscribe to my channel", bodyText: "i love programming"),
        Page(imageName: "coding", headerString: "Description text view", bodyText: "page cell")
    ]
    private let previousButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("PREV", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.gray, for: .normal)
        button.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return button
    }()
    private let nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("NEXT", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.red, for: .normal)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleNext(){
        let nextIndex = min(pageControl.currentPage + 1, pages.count - 1)
        let indexPath = IndexPath(item: nextIndex, section: 0)
        pageControl.currentPage = nextIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    @objc private func handlePrevious(){
        let previousIndex = max(0, pageControl.currentPage - 1)
        let indexPath = IndexPath(item: previousIndex, section: 0)
        pageControl.currentPage = previousIndex
        collectionView?.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }
    lazy var pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPage = 0
        pc.numberOfPages = pages.count
        pc.currentPageIndicatorTintColor = .red
        pc.pageIndicatorTintColor = .gray
        return pc
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.showsHorizontalScrollIndicator = false
        collectionView?.backgroundColor = .white
        collectionView?.register(StartingPageCollectionViewCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView?.isPagingEnabled = true
        setupBottomControls()
    }
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let x = targetContentOffset.pointee.x
        pageControl.currentPage = Int(x / view.frame.width)
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
    
}
