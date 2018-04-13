//
//  UniversitiesViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 4/12/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
import Kingfisher
import Moya
import RxCocoa
import RxSwift
import Moya_ModelMapper
import Hero
class UniversitiesViewViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    private var univerityCategories = [Category]()
        override func viewDidLoad() {
        super.viewDidLoad()
        configureBasics()
        configureCollectionView()
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title =
            Constants.Titles.UNIVERSITIES
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    func getData(){
        ServerAPIManager.sharedAPI.getUniversityCategories(setUniversityCategories, showError: showErrorAlert)
    }
    func setUniversityCategories(categories: [Category]){
        self.univerityCategories = categories
        self.collectionView.reloadData()
    }
}
extension UniversitiesViewViewController {
    func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: Constants.Categories.CellID.CATEGORIES_COLLECTIONVIEW_CELL, bundle: nil), forCellWithReuseIdentifier: Constants.Categories.CellID.CATEGORIES_COLLECTIONVIEW_CELL)
        collectionView?.contentInset = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    func configureBasics() {
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.view.backgroundColor = .white
    }
}
extension UniversitiesViewViewController:  UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return univerityCategories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Categories.CellID.CATEGORIES_COLLECTIONVIEW_CELL, for: indexPath) as! CategoriesCollectionViewCell
        cell.fillCell(category: univerityCategories[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let element = univerityCategories[indexPath.item]
        let storyboard = UIStoryboard.init(name: Constants.Storyboards.CATEGORIES, bundle: nil)
        let courseVC = storyboard.instantiateViewController(withIdentifier: Constants.Categories.ControllerID.COURSES_BY_SUBCATEGORY_VIEWCONTROLLER) as! CoursesBySubcategoryViewController
        courseVC.backImage = element.category_image_url
        courseVC.subcategoryName = element.title
        courseVC.cameFrom = CoursesBySubcategoryCameFrom.university
        courseVC.subcategory_id = element.id
        let navController = UINavigationController(rootViewController: courseVC)
        navController.isHeroEnabled = true
        navController.heroNavigationAnimationType = .fade
        self.navigationController?.show(courseVC, sender: self)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        var insets = 2
        var numOfColumns = 2
        if UIDevice.current.userInterfaceIdiom == .pad {
            insets = 4
            numOfColumns = 3
        }
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + CGFloat(insets))) / CGFloat(numOfColumns)
        return CGSize(width: itemSize, height: itemSize)
    }
}

