//
//  ViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 11/30/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit
import PullToRefreshKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private let refreshControl = UIRefreshControl()
    var recentCourses = SimplifiedCourses()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureCollectionView()
        getRecentData()
    }
    @objc private func getNewData(_ sender: Any){
        getRecentData()
    }
    func getRecentData(){
        ServerManager.shared.getRecentCourses(setRecentCourses, error: showErrorAlert)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Главная"
    }
    func setRecentCourses(courses: SimplifiedCourses) {
        self.recentCourses = courses
        collectionView.reloadData()
        self.collectionView.switchRefreshHeader(to: .normal(.none, 0.0))
    }
    
}
extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.recentCourses.array.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCollectionViewCell", for: indexPath) as! MainCollectionViewCell
        cell.fillCell(course: recentCourses.array[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = (collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right))
        return CGSize(width: itemSize, height: itemSize)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Course", bundle: nil)
        let courseVC = storyboard.instantiateViewController(withIdentifier: "DetailedCourseViewController") as! DetailedCourseViewController
        courseVC.course_id = recentCourses.array[indexPath.row].id
        print(recentCourses.array[indexPath.row].id)
        let navController = UINavigationController(rootViewController: courseVC)
        self.navigationController?.present(navController, animated: true, completion: nil)
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
        self.tabBarController?.tabBar.tintColor = UIColor.init(netHex: Colors.darkPurple)
        //self.tabBarController?.tabBar.barTintColor = UIColor.cyan
    }
    func configureCollectionView(){
        collectionView.register(UINib(nibName: "MainCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "MainCollectionViewCell")
        collectionView?.contentInset = UIEdgeInsets(top: 0, left: 12, bottom: 12, right: 12)
        let header = DefaultRefreshHeader.header()
        header.setText(Constants.Hint.Refresh.pull_to_refresh, mode: .pullToRefresh)
        header.setText(Constants.Hint.Refresh.relase_to_refresh, mode: .releaseToRefresh)
        header.setText(Constants.Hint.Refresh.success, mode: .refreshSuccess)
        header.setText(Constants.Hint.Refresh.refreshing, mode: .refreshing)
        header.setText(Constants.Hint.Refresh.failed, mode: .refreshFailure)
        header.imageRenderingWithTintColor = true
        header.durationWhenHide = 0.4
        collectionView.configRefreshHeader(with: header, action: { [weak self] in
            self?.getRecentData()
        })
    }
    
}
