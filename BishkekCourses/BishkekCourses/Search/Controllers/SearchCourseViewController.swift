//
//  SearchCourseViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 5/20/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
import KRProgressHUD
class SearchCourseViewController: UIViewController {
    private var simpleCourses = [SimpleCourse]()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        setNavigationBar()
        setNavigationBarItems()
        
        // Do any additional setup after loading the view.
    }
    func setNavigationBar() {
        let searchBar = UISearchBar()
        searchBar.delegate = self
        searchBar.searchBarStyle = .minimal
        //        searchBar.scopeButtonTitles = ["Курсы", "", "Гранты", "Акции"]
        //        searchBar.showsScopeBar = true
        searchBar.placeholder = "Поиск"
        searchBar.returnKeyType = .search
        navigationItem.titleView = searchBar
    }
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: Constants.Categories.CellID.COURSES_BY_SUBCATEGORY_TABLEVIEW_CELL, bundle: nil), forCellReuseIdentifier: Constants.Categories.CellID.COURSES_BY_SUBCATEGORY_TABLEVIEW_CELL)
    }

}
extension SearchCourseViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return simpleCourses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Categories.CellID.COURSES_BY_SUBCATEGORY_TABLEVIEW_CELL, for: indexPath) as! CoursesBySubcategoryTableViewCell
        let course = simpleCourses[indexPath.row]
        cell.fillCell(title: course.title, description: course.description, logo_image_url: course.logo_image_url, main_image_url: course.main_image_url)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showCourse(index: indexPath.row)
    }
    func showCourse(index: Int) {
        let course = simpleCourses[index]
        openCourse(id: course.id, name: course.title, logoUrl: course.logo_image_url, backUrl: course.main_image_url, description: course.description)
    }
}
extension SearchCourseViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        searchBar.setShowsCancelButton(false, animated: true)

        KRProgressHUD.show()
        if let text = searchBar.text {
            ServerAPIManager.sharedAPI.searchCourses(text: text, setCourses, showError: showErrorAlert)
        }
    }
    func setCourses(courses: [SimpleCourse]) {
        KRProgressHUD.dismiss()
        self.simpleCourses = courses
        self.tableView.reloadData()
    }
}

