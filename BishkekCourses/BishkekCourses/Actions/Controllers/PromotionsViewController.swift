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
    private var paginatedPromotion: PaginatedPromotion?
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getData()
        configureBasics()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = Constants.Titles.NEWS
    }
    func getData(){
        ServerAPIManager.sharedAPI.getActions(setActions, showError: showErrorAlert)
    }
    func setActions(actions: PaginatedPromotion){
        self.paginatedPromotion = actions
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
        tableView.register(UINib.init(nibName: Constants.Promotions.CellID.PROMOTION_TABLEVIEW_CELL, bundle: nil) , forCellReuseIdentifier: Constants.Promotions.CellID.PROMOTION_TABLEVIEW_CELL)
        tableView.configureRefreshHeader {
            self.getData()
        }
    }
}
extension PromotionsViewController: UITableViewDelegate, UITableViewDataSource, ActionsTableViewCellDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let paginatedPromotion = paginatedPromotion else {
            return 0
        }
        return paginatedPromotion.results.count
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Promotions.CellID.PROMOTION_TABLEVIEW_CELL, for: indexPath) as! PromotionTableViewCell
        cell.fillCell(action: paginatedPromotion!.results[indexPath.row], index: indexPath.row)
        cell.delegate = self
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let promotionVC = storyboard?.instantiateViewController(withIdentifier: Constants.Promotions.ControllerID.PROMOTIONS_DETAIL_VIEWCONTROLLER) as! PromotionsDetailViewController
        let action = self.paginatedPromotion!.results[indexPath.row]
        let simpleAction = SimplePromotion(id: action.id, title: action.title, description: action.description, end_date: action.end_date!, action_image: action.action_image)
        promotionVC.courseHeader = self.paginatedPromotion!.results[indexPath.row].course
        promotionVC.simpleAction = simpleAction
        self.navigationController?.show(promotionVC, sender: self)
    }
    func ActionsTableViewCellDidTapCourse(_ row: Int) {
        let course = self.paginatedPromotion!.results[row].course
        openCourse(id: course.id, name: course.title, logoUrl: course.logo_image_url, backUrl: course.main_image_url, description: course.description)
    }
}
