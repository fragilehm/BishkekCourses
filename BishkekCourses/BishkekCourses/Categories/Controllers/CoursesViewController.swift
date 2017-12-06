//
//  CoursesViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/4/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit

class CoursesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarItems()
        configureCollectionView()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Курсы"
    }
//    private func setNavigationBarItems(){
//        let backButton = UIButton.init(type: .system)
//        backButton.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), for: .normal)
//        backButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
//        backButton.imageView?.contentMode = .scaleAspectFit
//        backButton.addTarget(self, action: #selector(backPressed(_:)), for: .touchUpInside)
//        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
//    }
//    @objc func backPressed(_ button: UIButton) {
//        self.navigationController?.popViewController(animated: true)
//    }
}

extension CoursesViewController {
    func configureCollectionView(){
        collectionView.register(UINib(nibName: "CoursesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CoursesCollectionViewCell")
        collectionView?.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        
    }
}
extension CoursesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoursesCollectionViewCell", for: indexPath)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        return CGSize(width: itemSize, height: itemSize / 2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Course", bundle: nil)
        let courseVC = storyboard.instantiateViewController(withIdentifier: "DetailedCourseViewController")
        self.navigationController?.present(courseVC, animated: true, completion: nil)
    }
}

