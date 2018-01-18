//
//  NewsViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/2/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit
import HGPlaceholders
class NewsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: CollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        configureCollectionView()
        // Do any additional setup after loading the view.
    }
    func setNavigationBar() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        searchBar.placeholder = "Поиск"
        searchBar.returnKeyType = .search
        navigationItem.titleView = searchBar
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Лента"
    }

}
extension NewsViewController {
    func configureCollectionView(){
        collectionView.register(UINib(nibName: "NewsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "NewsCollectionViewCell")
        collectionView?.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        collectionView.placeholderDelegate = self
        //collectionView.showErrorPlaceholder()
        collectionView.placeholdersProvider = .summer
        let key = PlaceholderKey.custom(key: "starWars")
        collectionView?.showCustomPlaceholder(with: key)
    }
}
extension NewsViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewsCollectionViewCell", for: indexPath)
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
extension NewsViewController: PlaceholderDelegate {
    
    func view(_ view: Any, actionButtonTappedFor placeholder: Placeholder) {
        //(view as? CollectionView)?.showDefault()
    }
}
extension NewsViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
    }
}


