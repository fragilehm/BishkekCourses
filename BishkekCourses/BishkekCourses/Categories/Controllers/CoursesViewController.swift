//
//  CoursesViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/4/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit
import PullToRefreshKit
class CoursesViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    var subcategory_id = 0
    var courses = SimplifiedCourses()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarItems()
        configureCollectionView()
        getRecentData()
        
    }
    func getRecentData() {
        ServerManager.shared.getCoursesBySubcategory(subcategory_id: subcategory_id, setCourses, error: showErrorAlert)
    }
    func setCourses(courses: SimplifiedCourses){
        self.courses = courses
        self.collectionView.reloadData()
        self.collectionView.switchRefreshHeader(to: .normal(.none, 0.0))

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Курсы"
    }
}

extension CoursesViewController {
    func configureCollectionView(){
        collectionView.register(UINib(nibName: "CoursesCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CoursesCollectionViewCell")
        collectionView?.contentInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
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
extension CoursesViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courses.array.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoursesCollectionViewCell", for: indexPath) as! CoursesCollectionViewCell
        cell.fillCell(course: courses.array[indexPath.row])
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let itemSize = collectionView.frame.width - (collectionView.contentInset.left + collectionView.contentInset.right)
        return CGSize(width: itemSize, height: itemSize / 2)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Course", bundle: nil)
        let courseVC = storyboard.instantiateViewController(withIdentifier: "DetailedCourseViewController") as! DetailedCourseViewController
        courseVC.course_id = courses.array[indexPath.row].id
        self.navigationController?.show(courseVC, sender: self)
    }
}

