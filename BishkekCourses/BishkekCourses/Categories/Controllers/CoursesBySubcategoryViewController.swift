//
//  CoursesBySubcategoryViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/3/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
import Moya
import PullToRefreshKit
class CoursesBySubcategoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var subcategory_id = 0
    var subcategoryName = ""
    var backImage = ""
    var simpleCourses = [SimpleCourse]()
    override func viewDidLoad() {
        super.viewDidLoad()
        //setNavBarItems()
        configureTableView()
        getData()
 
    }
    func configureTableView(){
        //tableView.bounces = false
        if getDeviceName() == "iPhone 5.8" {
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -44).isActive = true
        }
        else {
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -20).isActive = true
        }
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "CoursesHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "CoursesHeaderTableViewCell")
        tableView.register(UINib.init(nibName: "CoursesBySubcategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CoursesBySubcategoryTableViewCell")
        tableView.estimatedRowHeight = 44
        tableView.bounces = false
//        let header = DefaultRefreshHeader.header()
//        header.setText(Constants.Hint.Refresh.pull_to_refresh, mode: .pullToRefresh)
//        header.setText(Constants.Hint.Refresh.relase_to_refresh, mode: .releaseToRefresh)
//        header.setText(Constants.Hint.Refresh.success, mode: .refreshSuccess)
//        header.setText(Constants.Hint.Refresh.refreshing, mode: .refreshing)
//        header.setText(Constants.Hint.Refresh.failed, mode: .refreshFailure)
//        header.imageRenderingWithTintColor = true
//        header.durationWhenHide = 0.4
//        tableView.configRefreshHeader(with: header, action: { [weak self] in
//            self?.getData()
//        })
    }
    func getData() {
        ServerAPIManager.sharedAPI.getCoursesBySubcategory(subcategory_id: self.subcategory_id, setCourses, showError: showErrorAlert)
        //self.tableView.switchRefreshHeader(to: .normal(.none, 0.0))

    }
    func setCourses(courses: [SimpleCourse]){
        self.simpleCourses = courses
        self.tableView.reloadData()
        //self.collectionView.switchRefreshHeader(to: .normal(.none, 0.0))
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
    }
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
        self.navigationController?.navigationBar.isHidden = false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func setNavBarItems(){
        let backButton = UIButton.init(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(dissmis(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    @objc func dissmis(_ button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CoursesBySubcategoryViewController: UITableViewDelegate, UITableViewDataSource, BackButtonDelegate {
    func back_tapper() {
        self.navigationController?.popViewController(animated: true)
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : simpleCourses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoursesHeaderTableViewCell", for: indexPath) as! CoursesHeaderTableViewCell
            cell.buttonDelegate = self
            cell.fillCell(imageString: backImage, title: subcategoryName)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoursesBySubcategoryTableViewCell", for: indexPath) as! CoursesBySubcategoryTableViewCell
            cell.fillCell(course: self.simpleCourses[indexPath.row])
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            let storyboard = UIStoryboard.init(name: "Course", bundle: nil)
            let courseVC = storyboard.instantiateViewController(withIdentifier: "DetailedCourseViewController") as! DetailedCourseViewController
            courseVC.course_id = simpleCourses[indexPath.row].id
            self.navigationController?.show(courseVC, sender: self)
        }
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 84 {
            UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
        }
        else
        {
            UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
        }

    }
}
