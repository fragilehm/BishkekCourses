//
//  MainViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 1/20/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
import PullToRefreshKit
class MainViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private let refreshControl = UIRefreshControl()
    var recentCourses = SimplifiedCourses()
    var images = ["coding", "art", "cat", "nature", "tree"]
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        configureTableView()
        getRecentData()
        // Do any additional setup after loading the view.
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
        tableView.reloadData()
        self.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
    }
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return images.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MainTableViewCell", for: indexPath) as! MainTableViewCell
        cell.mainImageView.image = UIImage(named: images[indexPath.item])

        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Course", bundle: nil)
        let courseVC = storyboard.instantiateViewController(withIdentifier: "DetailedCourseViewController") as! DetailedCourseViewController
        courseVC.course_id = recentCourses.array[indexPath.row].id
        let navController = UINavigationController(rootViewController: courseVC)
        self.navigationController?.present(navController, animated: true, completion: nil)
    }
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
        tableView.reloadData()
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
            self?.getRecentData()
        })
    }
    
}
