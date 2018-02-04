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
class SubCategoriesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var category_id = 0
    var insets: CGFloat = 12
    let disposeBag = DisposeBag()
    var subcategories: Variable<[Subcategory]> = Variable([])
    override func viewDidLoad() {
        super.viewDidLoad()
        if UIDevice.current.userInterfaceIdiom == .pad {
            insets = 24
        }
        setSwipeLeftAction()
        setNavigationBarItems()
        configureCollectionView()
        getData()
        bindCollectionView()
        bindCollectionViewSelected()
    }
   
    func getData(){
        ServerAPIManager.sharedAPI.getSubcategories(category_id: self.category_id, setSubcategories, showError: showErrorAlert)
    }
    func bindCollectionView(){
        subcategories.asObservable().bind(to: collectionView.rx.items(cellIdentifier: "SubCategoriesCollectionViewCell", cellType: SubCategoriesCollectionViewCell.self)) { row, element, cell in
            cell.fillCell(subcategory: element)
        }.disposed(by: disposeBag)
    }
    func bindCollectionViewSelected() {
        collectionView.rx.modelSelected(Subcategory.self).subscribe(onNext: {[weak self] element in
            guard let strongSelf = self else {return}
            let courseVC = strongSelf.storyboard?.instantiateViewController(withIdentifier: "CoursesBySubcategoryViewController") as! CoursesBySubcategoryViewController
            courseVC.backImage = element.subcategory_image_url
            courseVC.subcategoryName = element.title
            courseVC.subcategory_id = element.id
            //strongSelf.navigationController?.present(courseVC, animated: true, completion: nil)
            //strongSelf.navigationController?.pushViewController(courseVC, animated: true)
            strongSelf.navigationController?.show(courseVC, sender: self)
            
        }).disposed(by: disposeBag)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Подкатегории"
        print("SubcategoriesViewController resources: \(RxSwift.Resources.total)")

    }
    func setSubcategories(subcategories: [Subcategory]){
        self.subcategories.value = subcategories
    }
    deinit {
        print("deinit SubcategoriesViewController resources: \(RxSwift.Resources.total)")
    }
    
}
extension SubCategoriesViewController {
    func configureCollectionView(){
        collectionView.register(UINib(nibName: "SubCategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubCategoriesCollectionViewCell")
        collectionView?.contentInset = UIEdgeInsets(top: insets, left: insets, bottom: insets, right: insets)
        collectionView.rx.setDelegate(self as UIScrollViewDelegate).disposed(by: disposeBag)
    }
}
extension SubCategoriesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + insets)) / 2
        return CGSize(width: itemSize, height: itemSize * 3 / 4)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return insets
    }
}

