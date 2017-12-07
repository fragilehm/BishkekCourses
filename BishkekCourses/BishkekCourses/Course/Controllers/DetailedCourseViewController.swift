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
    }
    func setNavBarItems(){
        let navigationItem = UINavigationItem()
        let backButton = UIButton.init(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(dissmis(_:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: getRightItem(image: #imageLiteral(resourceName: "bookmark")))
        navigationItem.title = "English Zone"
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
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 34, height: 34)
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
            return 4
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HeaderTableViewCell", for: indexPath) as! HeaderTableViewCell
            cell.cellDelegate = self
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func iconPressed(_ index: Int) {
        if index == 0 {
            cellId = "DescriptionTableViewCell"
        }
        else if index == 1 {
            cellId = "CommentsTableViewCell"
        }
        else if index == 2 {
            cellId = "BranchesTableViewCell"
        }
        else if index == 3 {
            cellId = "ContactsTableViewCell"
        }
        else if index == 4 {
            cellId = "ServicesTableViewCell"
        }
        tableView.reloadData()
    }
}
