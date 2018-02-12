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
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        // Do any additional setup after loading the view.
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
            self?.tableView.reloadData()
            self?.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
        })
    }

}
extension PromotionsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsTableViewCell", for: indexPath) as! NewsTableViewCell
        cell.backImageView.image = UIImage(named: "coding")
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let courseVC = storyboard?.instantiateViewController(withIdentifier: "PromotionsDetailViewController") as! PromotionsDetailViewController
        self.navigationController?.show(courseVC, sender: self)
    }
    
}
