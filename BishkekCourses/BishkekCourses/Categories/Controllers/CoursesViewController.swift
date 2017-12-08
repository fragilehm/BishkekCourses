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
    var subcategory_id = 0
    var courses = Courses()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBarItems()
        configureCollectionView()
        ServerManager.shared.getCoursesBySubcategory(subcategory_id: subcategory_id, setCourses, error: showErrorAlert)
        
    }
    func setCourses(courses: Courses){
        self.courses = courses
        self.collectionView.reloadData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Курсы"
    }
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
        return courses.array.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CoursesCollectionViewCell", for: indexPath) as! CoursesCollectionViewCell
        cell.titleLabel.text = courses.array[indexPath.row].title
        cell.descriptionLabel.text = courses.array[indexPath.row].description
        let logo_url = URL(string: courses.array[indexPath.row].logo_image_url)
        cell.logoImageView.kf.setImage(with: logo_url)
        let background_url = URL(string: courses.array[indexPath.row].background_image_url)
        cell.mainImageView.kf.setImage(with: background_url)
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
        print(courses.array[indexPath.row].id)
        self.navigationController?.present(courseVC, animated: true, completion: nil)
    }
}

