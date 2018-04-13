//
//  NewsViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 4/13/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

import PullToRefreshKit
class NewsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var paginatedNews: PaginatedNews?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getData()
        configureBasics()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.setTabBarVisible(visible:true, animated: true)
        self.navigationItem.title = Constants.Titles.NEWS
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.setTabBarVisible(visible: true, animated: false)
    }
    func getData(){
        print("here")
        ServerAPIManager.sharedAPI.getNews(setNews, showError: showErrorAlert)
    }
    func setNews(news: PaginatedNews){
        print(news)
        self.paginatedNews = news
        tableView.reloadData()
        self.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
    }
    func configureBasics() {
        self.isHeroEnabled = true
        self.navigationController?.isHeroEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.view.backgroundColor = .white
    }
    func configureTableView(){
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 44
        tableView.register(UINib.init(nibName: Constants.News.CellID.NEWS_TABLEVIEW_CELL, bundle: nil) , forCellReuseIdentifier: Constants.News.CellID.NEWS_TABLEVIEW_CELL)
        tableView.configureRefreshHeader {
            self.getData()
        }
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0){
            self.tabBarController?.setTabBarVisible(visible:false, animated: true)
        }else{
            self.tabBarController?.setTabBarVisible(visible: true, animated: true)
        }
    }
}
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let paginatedNews = paginatedNews else {
            return 0
        }
        return paginatedNews.results.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.News.CellID.NEWS_TABLEVIEW_CELL, for: indexPath) as! NewssTableViewCell
        cell.fillCell(news: paginatedNews!.results[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let newsVC = storyboard?.instantiateViewController(withIdentifier: Constants.News.ControllerID.NEWS_DETAIL_VIEWCONTROLLER) as! NewsDetailViewController
        let news = self.paginatedNews!.results[indexPath.row]
        newsVC.news = news
        self.navigationController?.show(newsVC, sender: self)
    }
    
}


