//
//  CategoriesViewViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/1/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit
import Kingfisher
class CategoriesViewViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var categories = Categories()
    override func viewDidLoad() {
        super.viewDidLoad()
        ServerManager.shared.getCategories(setCategories, error: showErrorAlert)
        configureCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Категории"
    }
    func setCategories(categories: Categories){
        self.categories = categories
        self.collectionView.reloadData()
    }
}
extension CategoriesViewViewController {
    func configureCollectionView(){
        collectionView.register(UINib(nibName: "CategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CategoriesCollectionViewCell")
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)

    }
}
extension CategoriesViewViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.array.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        cell.titleLabel.text = categories.array[indexPath.row].title
        let url = URL(string: categories.array[indexPath.row].category_image_url)
        cell.categoriesImageView.kf.setImage(with: url)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 2)) / 2
        return CGSize(width: itemSize, height: itemSize)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let subCategoryVC = storyboard?.instantiateViewController(withIdentifier: "SubCategoriesViewController") as! SubCategoriesViewController
        subCategoryVC.category_id = categories.array[indexPath.row].id
        self.navigationController?.show(subCategoryVC, sender: self)
    }
}
