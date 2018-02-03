//
//  CoursesBySubcategoryViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/3/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
import Moya

class CoursesBySubcategoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var subcategory_id = 0
    var subcategoryName = ""
    var backImage = ""
    var simpleCourses = [SimpleCourse]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavBarItems()
        configureTableView()
        //let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
        //statusBar?.backgroundColor = UIColor.clear
//        self.navigationController!.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController!.navigationBar.shadowImage = UIImage()
//        self.navigationController!.navigationBar.isTranslucent = true
        getData()
        // Do any additional setup after loading the view.
    }
    func configureTableView(){
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "CoursesHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "CoursesHeaderTableViewCell")
        tableView.register(UINib.init(nibName: "CoursesBySubcategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CoursesBySubcategoryTableViewCell")
        tableView.estimatedRowHeight = 44
    }
    func getData() {
        ServerAPIManager.sharedAPI.getCoursesBySubcategory(subcategory_id: self.subcategory_id, setCourses, showError: showErrorAlert)
    }
    func setCourses(courses: [SimpleCourse]){
        self.simpleCourses = courses
        self.tableView.reloadData()
        //self.collectionView.switchRefreshHeader(to: .normal(.none, 0.0))
    }
//    override func viewWillAppear(_ animated: Bool) {
//        //UIApplication.shared.statusBarFrame =
//        self.navigationController?.navigationBar.barStyle = .blackOpaque
//    }
//    override var preferredStatusBarStyle: UIStatusBarStyle {
//        return .lightContent
//    }
    func setNavBarItems(){
        let backButton = UIButton.init(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(dissmis(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        //self.navigationController?.navigationBar.backgroundColor = .clear
    }
    @objc func dissmis(_ button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CoursesBySubcategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : simpleCourses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoursesHeaderTableViewCell", for: indexPath) as! CoursesHeaderTableViewCell
            cell.fillCell(imageString: backImage, title: subcategoryName)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoursesBySubcategoryTableViewCell", for: indexPath) as! CoursesBySubcategoryTableViewCell
            cell.fillCell(course: self.simpleCourses[indexPath.row])
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}
