//
//  SubCategoriesViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/4/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit

class SubCategoriesViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarItems()
        configureCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Подкатегории"
    }

    
}
extension SubCategoriesViewController {
    func configureCollectionView(){
        collectionView.register(UINib(nibName: "SubCategoriesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "SubCategoriesCollectionViewCell")
        collectionView?.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
    }
}
extension SubCategoriesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoriesCollectionViewCell", for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 10)) / 2
        return CGSize(width: itemSize, height: itemSize * 3 / 4)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let courseVC = storyboard?.instantiateViewController(withIdentifier: "CoursesViewController")
        self.navigationController?.show(courseVC!, sender: self)
    }
}

