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
class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    private let disposeBag = DisposeBag()
    private var viewModel =  SimpleCourseViewModel()
    var recentCourses: Variable<[SimpleCourse]> = Variable([])
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureTableView()
        getData()
        bindTableView()
        bindTableViewSelected()
    }
    func bindTableView(){
        viewModel.simpleCourses.asObservable().bind(to: tableView.rx.items(cellIdentifier: "MainTableViewCell", cellType: MainTableViewCell.self)) { row, element, cell in
            cell.fillCell(course: element)
            }.disposed(by: disposeBag)
        viewModel.error?.asObservable().subscribe(onNext: { [weak self] (message) in
            self?.showErrorAlert(message: message)
        }).disposed(by: disposeBag)
        viewModel.simpleCourses.asObservable().subscribe(onNext: { [weak self] (message) in
            self?.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
        }).disposed(by: disposeBag)
        
    }
    func bindTableViewSelected(){
        tableView.rx.modelSelected(SimpleCourse.self).subscribe(onNext: {[weak self] element in
            guard let strongSelf = self else {return}
            let storyboard = UIStoryboard.init(name: "Course", bundle: nil)
            let courseVC = storyboard.instantiateViewController(withIdentifier: "DetailedCourseViewController") as! DetailedCourseViewController
            courseVC.course_id = element.id
            strongSelf.navigationController?.show(courseVC, sender: self)
        }).disposed(by: disposeBag)
    }
    func getData(){
        viewModel.fetchData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Главная"
        print("MainViewController resources: \(RxSwift.Resources.total)")

    }
    deinit {
        print("deinit MainViewController resources: \(RxSwift.Resources.total)")
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
        tableView.configRefreshHeader(with: header, action: { [weak self] in
            self?.getData()
        })
    }
}
