//
//  FavoriteViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/2/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit
import HGPlaceholders
class FavoriteViewController: UIViewController {

    @IBOutlet weak var collectionView: CollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Избранные"
    }

}
extension FavoriteViewController {
    func configureCollectionView(){
        collectionView.register(UINib(nibName: "FavoriteCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "FavoriteCollectionViewCell")
        collectionView?.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        collectionView.placeholderDelegate = self
        //collectionView.showErrorPlaceholder()
        collectionView.placeholdersProvider = .summer
        let key = PlaceholderKey.custom(key: "starWars")
        collectionView?.showCustomPlaceholder(with: key)
        
    }
}
extension FavoriteViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCollectionViewCell", for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right + 2)
        return CGSize(width: itemSize, height: 142)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        let vc = self.storyboard?.instantiateViewController(withIdentifier: "NewsTableViewController")
        //        self.navigationController?.show(vc!, sender: self)
    }
}
extension FavoriteViewController: PlaceholderDelegate {
    
    func view(_ view: Any, actionButtonTappedFor placeholder: Placeholder) {
        //(view as? CollectionView)?.showDefault()
        let alert = UIAlertController(title: "hello", message: "world", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "category", style: .default, handler: nil)
        let cancel = UIAlertAction(title: "cancel", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.addAction(cancel)
        self.present(alert, animated: true, completion: nil)
    }
}


