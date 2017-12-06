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
    var cellId = "DescriptionTableViewCell"
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
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!{
        didSet {
            let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(favoriteTapped(tapGestureRecognizer:)))
            favoriteImageView.isUserInteractionEnabled = true
            favoriteImageView.addGestureRecognizer(tapGestureRecognizer)
        }
    }
    @objc func favoriteTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        // Do any additional setup after loading the view.
    }

}

extension DetailedCourseViewController {
    func configureTableView(){
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: "HeaderTableViewCell")
        tableView.register(UINib.init(nibName: "CommentsTableViewCell", bundle: nil), forCellReuseIdentifier: "CommentsTableViewCell")
        tableView.register(UINib.init(nibName: "ServicesTableViewCell", bundle: nil), forCellReuseIdentifier: "ServicesTableViewCell")
        tableView.register(UINib.init(nibName: "BranchesTableViewCell", bundle: nil), forCellReuseIdentifier: "BranchesTableViewCell")
        tableView.register(UINib.init(nibName: "ContactsTableViewCell", bundle: nil), forCellReuseIdentifier: "ContactsTableViewCell")
        tableView.register(UINib.init(nibName: "DescriptionTableViewCell", bundle: nil), forCellReuseIdentifier: "DescriptionTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.reloadData()
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
