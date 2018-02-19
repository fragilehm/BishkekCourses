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
    private let disposeBag = DisposeBag()
    let segmentView: SegmentView = {
        let segmentView = SegmentView()
        segmentView.translatesAutoresizingMaskIntoConstraints = false
        return segmentView
    }()
    
    private var viewModel =  SimpleCourseViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        addSegmetView()
        configureTabBar()
        configureTableView()
        bindTableView()
        getData()
        bindTableViewSelected()
        self.isHeroEnabled = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.heroNavigationAnimationType = .fade
        self.navigationItem.title = "Главная"
        self.navigationController?.navigationBar.shadowImage = UIImage()
        //self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        print("MainViewController resources: \(RxSwift.Resources.total)")
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.shadowImage = nil
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
            //let storyboard = UIStoryboard.init(name: "Course", bundle: nil)
            let courseVC = UIStoryboard.init(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "DetailedCourseViewController") as! DetailedCourseViewController
            //strongSelf.openCourse(id: course.id, name: course.title, logoUrl: course.logo_image_url, backUrl: course.main_image_url)
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
            segmentView.bottomAnchor.constraint(equalTo: tableView.topAnchor),
            segmentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            segmentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            segmentView.heightAnchor.constraint(equalToConstant: 44)
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
    
    deinit {
        print("deinit MainViewController resources: \(RxSwift.Resources.total)")
    }
    @available(iOS 10.0, *)
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        print(URL.absoluteString)
        let subCategoryVC = UIStoryboard.init(name: "Categories", bundle: nil).instantiateViewController(withIdentifier: "CoursesBySubcategoryViewController") as! CoursesBySubcategoryViewController
        print(URL.absoluteString.removingPercentEncoding!)
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
        //subCategoryVC.title = seperatedString[1]
        self.navigationController?.show(subCategoryVC, sender: self)
        //UIApplication.shared.open(URL, options: [:])
        return false
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
    func configureTabBar(){
        let bars = self.tabBarController?.tabBar.items
        for (index, bar) in bars!.enumerated() {
            bar.title = nil
            bar.image = MainPageItems(rawValue: index)?.getImage()
            bar.imageInsets = UIEdgeInsets(top: 6, left: 0, bottom: -6, right: 0)
        }
        self.tabBarController?.tabBar.tintColor = UIColor.black
        //self.tabBarController?.tabBar.unselectedItemTintColor = UIColor.black
        //self.tabBarController?.tabBar.barTintColor = UIColor.cyan
    }
    func configureTableView(){
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 100
        tableView.rx.setDelegate(self as UIScrollViewDelegate).disposed(by: disposeBag)
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "MainTableViewCell")
        //tableView.View?.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
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
