//
//  PromotionsViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/9/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
import PullToRefreshKit
class PromotionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    private var actions = [Promotion]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getData()
        self.isHeroEnabled = true
        self.navigationController?.isHeroEnabled = true
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        self.navigationController?.view.backgroundColor = .white
        //self.navigationController?.heroNavigationAnimationType = .fade
        // Do any additional setup after loading the view.
    }
    func getData(){
        ServerAPIManager.sharedAPI.getActions(setActions, showError: showErrorAlert)
    }
    func setActions(actions: [Promotion]){
        self.actions = actions
        tableView.reloadData()
        self.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
    }
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.title = "Акции"
        self.navigationItem.title = "Акции"
    }
    func configureTableView(){
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 44
        tableView.register(UINib.init(nibName: "NewsTableViewCell", bundle: nil) , forCellReuseIdentifier: "NewsTableViewCell")
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
extension PromotionsViewController: UITableViewDelegate, UITableViewDataSource, ActionsTableViewCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return actions.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.fillCell(action: actions[indexPath.row], index: indexPath.row)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let promotionVC = storyboard?.instantiateViewController(withIdentifier: "PromotionsDetailViewController") as! PromotionsDetailViewController
        let action = self.actions[indexPath.row]
        let simpleAction = SimplePromotion(id: action.id, title: action.title, description: action.description, end_date: action.end_date, action_image: action.action_image)
        promotionVC.courseHeader = self.actions[indexPath.row].course
        promotionVC.simpleAction = simpleAction
        self.navigationController?.show(promotionVC, sender: self)
    }
    func ActionsTableViewCellDidTapCourse(_ row: Int) {
        let course = actions[row].course
        openCourse(id: course.id, name: course.title, logoUrl: course.logo_image_url, backUrl: course.main_image_url, description: course.description)
//        let courseVC = UIStoryboard.init(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "DetailedCourseViewController") as! DetailedCourseViewController
//        courseVC.courseName = course.title
//        courseVC.courseBackImage = course.background_image_url
//        courseVC.courseLogo = course.logo_image_url
//        courseVC.course_id = course.id
//        self.navigationController?.show(courseVC, sender: self)
        //print(actions[courseId].course.title)
    }
}
