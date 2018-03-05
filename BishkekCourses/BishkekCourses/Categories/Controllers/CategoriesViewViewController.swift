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
    var categories: Variable<[Category]> = Variable([])
    let disposeBag = DisposeBag()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        navigationController?.view.backgroundColor = .white
        getData()
        bindCollectionView()
        bindCollectionViewSelected()
    }
    func bindCollectionView(){
        categories.asObservable().bind(to: collectionView.rx.items(cellIdentifier: Constants.Categories.CellID.CATEGORIES_COLLECTIONVIEW_CELL, cellType: CategoriesCollectionViewCell.self)) { row, element, cell in
            cell.fillCell(category: element)
            }.disposed(by: disposeBag)
    }
    func bindCollectionViewSelected(){
        collectionView.rx.modelSelected(Category.self).subscribe(onNext: {[weak self] element in
            guard let strongSelf = self else {return}
            let subCategoryVC = strongSelf.storyboard?.instantiateViewController(withIdentifier: Constants.Categories.ControllerID.SUB_CATEGORIES_VIEWCONTROLLER) as! SubCategoriesViewController
            subCategoryVC.category_id = element.id
            strongSelf.navigationController?.show(subCategoryVC, sender: self)
        }).disposed(by: disposeBag)
    }
    func getData(){
        ServerAPIManager.sharedAPI.getCategories(setCategories, showError: showErrorAlert)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title =
            Constants.Titles.CATEGORIES
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        //print("CategoriesViewController resources: \(RxSwift.Resources.total)")
    }
    func setCategories(categories: [Category]){
        self.categories.value = categories
    }
}
extension CategoriesViewViewController {
    func configureCollectionView(){
        collectionView.rx.setDelegate(self as UIScrollViewDelegate).disposed(by: disposeBag)
        collectionView.register(UINib(nibName: Constants.Categories.CellID.CATEGORIES_COLLECTIONVIEW_CELL, bundle: nil), forCellWithReuseIdentifier: Constants.Categories.CellID.CATEGORIES_COLLECTIONVIEW_CELL)
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}
extension CategoriesViewViewController:  UICollectionViewDelegateFlowLayout {
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
