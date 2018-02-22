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
class MainViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    private let disposeBag = DisposeBag()
    private var yBeginOffset: CGFloat = 0
    let segmentView: SegmentView = {
        let segmentView = SegmentView()
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        return segmentView
    }()
    
    private var viewModel =  SimpleCourseViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        //addSegmetView()
        configureTabBar()
        configureTableView()
        configureBasics()
        bindTableView()
        getData()
        bindTableViewSelected()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.setTabBarVisible(visible: true, animated: false)
        self.navigationController?.heroNavigationAnimationType = .fade
        self.navigationItem.title = "Главная"
    }
    func bindTableView(){
        viewModel.simpleCourses.asObservable().bind(to: tableView.rx.items(cellIdentifier: "MainTableViewCell", cellType: MainTableViewCell.self)) { row, element, cell in
            cell.fillCell(course: element)
            cell.textView.delegate = self
            }.disposed(by: disposeBag)
        viewModel.error.asObservable().subscribe(onNext: { [weak self] (message) in            self?.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
            self?.showErrorAlert(message: message)
        }).disposed(by: disposeBag)
        viewModel.simpleCourses.asObservable().subscribe(onNext: { [weak self] (message) in
            self?.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
        }).disposed(by: disposeBag)
    }
    func bindTableViewSelected(){
        tableView.rx.modelSelected(SimpleCourse.self).subscribe(onNext: {[weak self] course in
            guard let strongSelf = self else {return}
            let courseVC = UIStoryboard.init(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "DetailedCourseViewController") as! DetailedCourseViewController
            courseVC.course_id = course.id
            courseVC.courseDescription = course.description
            courseVC.courseName = course.title
            courseVC.courseLogo = course.logo_image_url
            courseVC.courseBackImage = course.main_image_url
            strongSelf.navigationController?.show(courseVC, sender: self)
        }).disposed(by: disposeBag)
    }
    func getData(){
        viewModel.fetchData()
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
        let subCategoryVC = UIStoryboard.init(name: "Categories", bundle: nil).instantiateViewController(withIdentifier: "CoursesBySubcategoryViewController") as! CoursesBySubcategoryViewController
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
        self.navigationController?.present(navController, animated: true, completion: nil)
        return false
    }

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0){
            self.segmentView.heightAnchor.constraint(equalToConstant: 0).isActive = true
            self.segmentView.animateConstraintWithDuration()
            self.tabBarController?.setTabBarVisible(visible:false, animated: true)
        }else{
            self.segmentView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            self.segmentView.animateConstraintWithDuration()
            self.tabBarController?.setTabBarVisible(visible: true, animated: true)
        }
    }
    func textView(_ textView: UITextView, shouldInteractWith textAttachment: NSTextAttachment, in characterRange: NSRange) -> Bool {
        print(textAttachment)
        return false
    }
}
extension MainViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
extension MainViewController {
    func configureBasics() {
        self.navigationController?.view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
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
        tableView.rx.setDelegate(self as UIScrollViewDelegate).disposed(by: disposeBag)
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        let header = DefaultRefreshHeader.header()
        header.setText(Constants.Hint.Refresh.pull_to_refresh, mode: .pullToRefresh)
        header.setText(Constants.Hint.Refresh.relase_to_refresh, mode: .releaseToRefresh)
        header.setText(Constants.Hint.Refresh.success, mode: .refreshSuccess)
        header.setText(Constants.Hint.Refresh.refreshing, mode: .refreshing)
        header.setText(Constants.Hint.Refresh.failed, mode: .refreshFailure)
        header.imageRenderingWithTintColor = true
        header.durationWhenHide = 0.4
        tableView.configRefreshHeader(with: getRefreshHeader(), action: { [weak self] in
            self?.getData()
        })
    }
}
