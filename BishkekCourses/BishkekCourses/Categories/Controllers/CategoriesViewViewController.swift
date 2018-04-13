//
//  CategoriesViewViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/1/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit
import Kingfisher
import Moya
import RxCocoa
import RxSwift
import Moya_ModelMapper
import Hero
class CategoriesViewViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    private var categories = [Category]()
    private var univerityCategories = [Category]()
    private var courseCategories = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBasics()
        configureCollectionView()
        getData()
        //configureSegmentControl()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title =
            Constants.Titles.CATEGORIES
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    func getData(){
        ServerAPIManager.sharedAPI.getCategories(setCategories, showError: showErrorAlert)
        //ServerAPIManager.sharedAPI.getUniversityCategories(setUniversityCategories, showError: showErrorAlert)
    }
//    func setUniversityCategories(categories: [Category]){
//        self.univerityCategories = categories
//        self.collectionView.reloadData()
//    }
    func setCategories(categories: [Category]){
        self.courseCategories = categories
        self.collectionView.reloadData()
    }
    
}
extension CategoriesViewViewController {
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
//    func configureSegmentControl() {
//        segmentControl.addTarget(self, action: #selector(segmentControlValueChanged), for: .valueChanged)
//    }
//    @objc func segmentControlValueChanged(segment: UISegmentedControl) {
//        if segment.selectedSegmentIndex == 0 {
//            categories = courseCategories
//        } else {
//            categories = univerityCategories
//        }
//        self.collectionView.reloadData()
//    }
}
extension CategoriesViewViewController:  UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseCategories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Categories.CellID.CATEGORIES_COLLECTIONVIEW_CELL, for: indexPath) as! CategoriesCollectionViewCell
        cell.fillCell(category: courseCategories[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        //if segmentControl.selectedSegmentIndex == 0 {
            let subCategoryVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.Categories.ControllerID.SUB_CATEGORIES_VIEWCONTROLLER) as! SubCategoriesViewController
            subCategoryVC.category_id = courseCategories[indexPath.item].id
            self.navigationController?.show(subCategoryVC, sender: self)
//        }
//        else {
//            let element = univerityCategories[indexPath.item]
//            let courseVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.Categories.ControllerID.COURSES_BY_SUBCATEGORY_VIEWCONTROLLER) as! CoursesBySubcategoryViewController
//            courseVC.backImage = element.category_image_url
//            courseVC.subcategoryName = element.title
//            courseVC.cameFrom = CoursesBySubcategoryCameFrom.university
//            courseVC.subcategory_id = element.id
//            let navController = UINavigationController(rootViewController: courseVC)
//            navController.isHeroEnabled = true
//            navController.heroNavigationAnimationType = .fade
//            self.navigationController?.show(courseVC, sender: self)
//        }
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //var insets = 5
        var numOfColumns = 2
        if UIDevice.current.userInterfaceIdiom == .pad {
            //insets = 10
            numOfColumns = 3
        }
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)) / CGFloat(numOfColumns)
        return CGSize(width: itemSize, height: itemSize)
//        let width = UIScreen.main.bounds.width / 2
//        let height = width
//        return CGSize(width: width, height: height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}
