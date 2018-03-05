//
//  TutorViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/22/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class TutorViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var tutors = [Tutor]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getData()
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.title = Constants.Titles.TUTOR
    }
    func getData() {
        ServerAPIManager.sharedAPI.getTutors(setTutors, showError: showErrorAlert)
    }
    func setTutors(tutors: [Tutor]){
        self.tutors = tutors
        self.tableView.reloadData()
        self.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
    }
}

extension TutorViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tutors.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Tutor.CellID.TUTOR_TABLEVIEW_CELL, for: indexPath) as! TutorTableViewCell
        cell.fillCell(tutor: tutors[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tutorVC = storyboard?.instantiateViewController(withIdentifier: Constants.Tutor.ControllerID.TUTOR_DETAIL_VIEWCONTROLLER) as! TutorDetailViewController
        tutorVC.tutor = self.tutors[indexPath.row]
        self.navigationController?.show(tutorVC, sender: self)
    }
}
extension TutorViewController {
    func configureTableView() {
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: Constants.Tutor.CellID.TUTOR_TABLEVIEW_CELL, bundle: nil) , forCellReuseIdentifier: Constants.Tutor.CellID.TUTOR_TABLEVIEW_CELL)
        tableView.configureRefreshHeader {
            self.getData()
        }
    }
}
