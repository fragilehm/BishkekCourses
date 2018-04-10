//
//  MainViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 1/20/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
import PullToRefreshKit
import Moya_ModelMapper
import RxCocoa
import RxSwift
import Moya
import Hero
import PKHUD
import KRProgressHUD
import Alamofire
import SwiftyJSON
class MainViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    private let disposeBag = DisposeBag()
    private let segmentView: SegmentView = {
        let segmentView = SegmentView()
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        return segmentView
    }()
    private var paginatedCourse: PaginatedCourse?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureTableView()
        configureBasics()
        getData()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.setTabBarVisible(visible:true, animated: true)
        self.navigationItem.title = Constants.Titles.MAIN
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.setTabBarVisible(visible: true, animated: false)
    }
    func getData(pageNumber: Int = 1, isRefresh: Bool = false){
        if !isRefresh {
            KRProgressHUD.show()
        }
        ServerAPIManager.sharedAPI.getRecentCourses(pageNumber: pageNumber, setPaginatedCourse, showError: showErrorAlert)
    }
    func setPaginatedCourse(paginatedCourse: PaginatedCourse) {
        KRProgressHUD.dismiss()
        self.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
        self.paginatedCourse = paginatedCourse
        self.tableView.reloadData()
    }
    func addSegmetView(){
        segmentView.popularButton.addTarget(self, action: #selector(popularPressed), for: .touchUpInside)
        segmentView.recentButton.addTarget(self, action: #selector(recentPressed), for: .touchUpInside)

        self.view.addSubview(segmentView)
        if #available(iOS 11.0, *) {
            segmentView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            segmentView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
        }
        NSLayoutConstraint.activate([
            segmentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentView.heightAnchor.constraint(equalToConstant: 60),
            segmentView.bottomAnchor.constraint(equalTo: tableView.topAnchor)
        ])
    }
    @objc func popularPressed(){
        segmentView.recentButton.isEnabled = true
        segmentView.popularButton.isEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.segmentView.recentButton.setTitleColor(.lightGray, for: .normal)
            self.segmentView.popularButton.setTitleColor(.black, for: .normal)
            self.segmentView.bottomView.frame.origin.x += Constants.SCREEN_WIDTH / 2
        }
    }
    @objc func recentPressed(){
        segmentView.popularButton.isEnabled = true
        segmentView.recentButton.isEnabled = false
        UIView.animate(withDuration: 0.3) {
            self.segmentView.popularButton.setTitleColor(.lightGray, for: .normal)
            self.segmentView.recentButton.setTitleColor(.black, for: .normal)
            self.segmentView.bottomView.frame.origin.x -= Constants.SCREEN_WIDTH / 2
        }
    }
    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        let subCategoryVC = UIStoryboard.init(name: Constants.Storyboards.CATEGORIES, bundle: nil).instantiateViewController(withIdentifier: Constants.Categories.ControllerID.COURSES_BY_SUBCATEGORY_VIEWCONTROLLER) as! CoursesBySubcategoryViewController
        let seperatedString =  URL.absoluteString.removingPercentEncoding?.components(separatedBy: " ")
        var name = ""
        for index in 2..<seperatedString!.count{
            name.append(seperatedString![index])
            if index < seperatedString!.count {
                name.append(" ")
            }
        }
        subCategoryVC.subcategory_id = Int(seperatedString![0])!
        subCategoryVC.subcategoryName = name
        subCategoryVC.backImage = seperatedString![1]
        let navController = UINavigationController(rootViewController: subCategoryVC)
        navController.isHeroEnabled = true
        navController.heroNavigationAnimationType = .fade
        self.navigationController?.show(subCategoryVC, sender: self)
        return false
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0){
            self.tabBarController?.setTabBarVisible(visible:false, animated: true)
        }else{
            self.tabBarController?.setTabBarVisible(visible: true, animated: true)
        }
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let paginatedCourse = paginatedCourse else {
            return 0
        }
        return paginatedCourse.results.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Main.CellID.MAIN_TABLEVIEW_CELL, for: indexPath) as! MainTableViewCell
        cell.fillCell(course: paginatedCourse!.results[indexPath.row])
        cell.textView.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let courseVC = UIStoryboard.init(name: Constants.Storyboards.COURSE, bundle: nil).instantiateViewController(withIdentifier: Constants.DetailedCourse.ControllerID.DETAILED_COURSE_VIEWCONTROLLER) as! DetailedCourseViewController
        let course = paginatedCourse!.results[indexPath.row]
        courseVC.course_id = course.id
        courseVC.courseDescription = course.description
        courseVC.courseName = course.title
        courseVC.courseLogo = course.logo_image_url
        courseVC.courseBackImage = course.main_image_url
        self.navigationController?.show(courseVC, sender: self)
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == (self.paginatedCourse?.results.count)! - 1 && indexPath.row < (paginatedCourse?.count)! - 1 {
            ServerAPIManager.sharedAPI.getRecentCourses(pageNumber: (self.paginatedCourse?.results.count)! / 20 + 1, appentRecentCourses, showError: showErrorAlert)
        }
    }
    func appentRecentCourses(courses: PaginatedCourse){
        self.paginatedCourse?.results.append(contentsOf: courses.results)
        self.tableView.reloadData()
    }
}
extension MainViewController {
    func configureBasics() {
        self.navigationController?.view.backgroundColor = .white
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.isHeroEnabled = true
    }
    func configureTabBar(){
        let bars = self.tabBarController?.tabBar.items
        for (index, bar) in bars!.enumerated() {
            bar.title = nil
            bar.image = MainPageItems(rawValue: index)?.getImage()
            bar.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        self.tabBarController?.tabBar.tintColor = UIColor.black
    }
    func configureTableView(){
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.register(UINib(nibName: Constants.Main.CellID.MAIN_TABLEVIEW_CELL, bundle: nil), forCellReuseIdentifier: Constants.Main.CellID.MAIN_TABLEVIEW_CELL)
        tableView.configureRefreshHeader {
            self.getData(isRefresh: true)
        }
    }
}
