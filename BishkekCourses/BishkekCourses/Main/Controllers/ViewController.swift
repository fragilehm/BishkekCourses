//
//  ViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 11/30/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureCollectionView()
        //self.navigationItem.title = "Главная"
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Главная"
    }
}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right))
        //print(itemSize, "  000")
        return CGSize(width: itemSize, height: itemSize)
    }
}
extension ViewController {
    func configureTabBar(){
        let bars = self.tabBarController?.tabBar.items
        for (index, bar) in bars!.enumerated() {
            bar.title = nil
            bar.image = MainPageItems(rawValue: index)?.getImage()
            bar.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
    }
    func configureCollectionView(){
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView?.contentInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    }
    
}
