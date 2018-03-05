//
//  SubCategoriesViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/4/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import Hero
class SubCategoriesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var category_id = 0
    var insets: CGFloat = 0
    let disposeBag = DisposeBag()
    var subcategories = [Subcategory]()
    private var backImage: String?
    private var originFrame: CGRect?
    private var labelFrame: CGRect?
    private var labelTitle: String?
    private var images = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.userInterfaceIdiom == .pad {
            insets = 0
        }
        setNavigationBarItems()
        configureCollectionView()
        getData()
        self.isHeroEnabled = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = Constants.Titles.SUBCATEGORIES
    }
    func addSwipeLeftAction(){
        let swipeLeftGR = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(swipeLeft(swipeRecognizer:)))
        swipeLeftGR.edges = .left
        self.view.addGestureRecognizer(swipeLeftGR)
    }
    @objc func swipeLeft(swipeRecognizer: UIScreenEdgePanGestureRecognizer){
        let translation = swipeRecognizer.translation(in: swipeRecognizer.view!.superview!)
        var progress = (translation.x / 200)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        switch swipeRecognizer.state {
        case .began:
            self.hero_dismissViewController()
        case .changed:
            let viewPosition = CGPoint(x: view.center.x + translation.x,
                                       y: view.center.y)
            Hero.shared.update(progress)
            Hero.shared.apply(modifiers: [.position(viewPosition)], to: view)
        default:
            if progress + swipeRecognizer.velocity(in: nil).x / view.bounds.width > 1 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.heroNavigationAnimationType = .auto
    }
   
    func getData(){
        ServerAPIManager.sharedAPI.getSubcategories(category_id: self.category_id, setSubcategories, showError: showErrorAlert)
    }
    func setSubcategories(subcategories: [Subcategory]){
        self.subcategories = subcategories
        collectionView.reloadData()
    }
}

extension SubCategoriesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return subcategories.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Categories.CellID.SUBCATEGORIES_COLLECTIONVIEW_CELL, for: indexPath) as! SubCategoriesCollectionViewCell
        cell.fillCell(subcategory: subcategories[indexPath.item])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let element = subcategories[indexPath.item]
        let courseVC = self.storyboard?.instantiateViewController(withIdentifier: Constants.Categories.ControllerID.COURSES_BY_SUBCATEGORY_VIEWCONTROLLER) as! CoursesBySubcategoryViewController
        courseVC.backImage = element.subcategory_image_url
        courseVC.subcategoryName = element.title
        courseVC.subcategory_id = element.id
        let navController = UINavigationController(rootViewController: courseVC)
        navController.isHeroEnabled = true
        navController.heroNavigationAnimationType = .fade
        self.navigationController?.show(courseVC, sender: self)
    }
}

extension SubCategoriesViewController {
    func configureCollectionView(){
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UINib(nibName: Constants.Categories.CellID.SUBCATEGORIES_COLLECTIONVIEW_CELL, bundle: nil), forCellWithReuseIdentifier: Constants.Categories.CellID.SUBCATEGORIES_COLLECTIONVIEW_CELL)
        collectionView?.contentInset = UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
    }
}
extension SubCategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - 2) / 2
        return CGSize(width: itemSize, height: itemSize * 3 / 4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return insets
    }
}

