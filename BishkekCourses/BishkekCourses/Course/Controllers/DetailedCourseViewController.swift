//
//  DetailedCourseViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/6/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit

class DetailedCourseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var navBar: UINavigationBar!
    var cellId = "DescriptionTableViewCell"
    var course_id = 0
    var course = Course()
    private var isFavorite = false
    @IBOutlet weak var backImageView: UIImageView!{
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(backTapped(tapGestureRecognizer:)))
            backImageView.isUserInteractionEnabled = true
            backImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @objc func backTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        self.dismiss(animated: true, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setNavBarItems()
        ServerManager.shared.getCourseDetails(course_id: course_id, setCourse, error: showErrorAlert)
    }
    func setCourse(course: Course){
        self.course = course
        self.navBar.items![0].title = course.title
        tableView.reloadData()
    }
    func setNavBarItems(){
        let navigationItem = UINavigationItem()
        let backButton = UIButton.init(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(dissmis(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: getRightItem(image: #imageLiteral(resourceName: "bookmark")))
        self.navBar.setItems([navigationItem], animated: false)
    }
    @objc func dissmis(_ button: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    @objc func favoritePressed(_ button: UIButton) {
        if !isFavorite {
            self.navBar.items![0].rightBarButtonItem?.customView = getRightItem(image: #imageLiteral(resourceName: "favorite"))
        }
        else {
            self.navBar.items![0].rightBarButtonItem?.customView = getRightItem(image: #imageLiteral(resourceName: "bookmark"))
        }
        isFavorite = !isFavorite
    }
    func getRightItem(image: UIImage) -> UIButton {
        let favoriteButton = UIButton.init(type: .system)
        favoriteButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        favoriteButton.imageView?.contentMode = .scaleAspectFit
        favoriteButton.addTarget(self, action: #selector(favoritePressed(_:)), for: .touchUpInside)
        return favoriteButton
    }
}

extension DetailedCourseViewController {
    func configureTableView(){
        tableView.tableFooterView = UIView()
        registerCell(nibName: "HeaderTableViewCell")
        registerCell(nibName: "CommentsTableViewCell")
        registerCell(nibName: "ServicesTableViewCell")
        registerCell(nibName: "BranchesTableViewCell")
        registerCell(nibName: "ContactsTableViewCell")
        registerCell(nibName: "DescriptionTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.reloadData()
    }
    func registerCell(nibName: String){
        tableView.register(UINib.init(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
}
extension DetailedCourseViewController: UITableViewDelegate, UITableViewDataSource, ButtonDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        else {
            switch cellId {
            case "DescriptionTableViewCell":
                return 1
            case "CommentsTableViewCell":
                return 0
            case "BranchesTableViewCell":
                return course.branches.array.count
            case "ContactsTableViewCell":
                return course.contacts.array.count
            default:
                return course.services.array.count
            }
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            cell.fillCell(course: course)
            cell.cellDelegate = self
            return cell
        }
        else {
            switch cellId {
            case "DescriptionTableViewCell":
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as!
                DescriptionTableViewCell
                cell.fillCell(description: course.description)
                return cell
            case "CommentsTableViewCell":
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as!
                CommentsTableViewCell
                //cell.fillCell(course: course)
                return cell
            case "BranchesTableViewCell":
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! BranchesTableViewCell
                cell.fillCell(branch: course.branches.array[indexPath.row])
                return cell
            case "ContactsTableViewCell":
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactsTableViewCell
                cell.fillCell(contact: course.contacts.array[indexPath.row])
                return cell
            default:
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ServicesTableViewCell
                cell.fillCell(service: course.services.array[indexPath.row])
                return cell
            }
            
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 1 {
            switch cellId {
            case "DescriptionTableViewCell":
                print("description")
            case "CommentsTableViewCell":
                print("comments")
            case "BranchesTableViewCell":
                print("branches")
            case "ContactsTableViewCell":
                print("contacts")
            default:
                print("services")
            }
        }
    }
    func iconPressed(_ index: Int) {
        switch index {
        case 0:
            cellId = "DescriptionTableViewCell"
        case 1:
            cellId = "CommentsTableViewCell"
        case 2:
            cellId = "BranchesTableViewCell"
        case 3:
            cellId = "ContactsTableViewCell"
        default:
            cellId = "ServicesTableViewCell"

        }
        tableView.reloadData()
    }
}
