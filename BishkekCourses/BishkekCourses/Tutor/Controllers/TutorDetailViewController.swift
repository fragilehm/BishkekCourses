//
//  TutorDetailViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/22/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit

class TutorDetailViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let header = TutorHeaderView()
        header.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 200)
        tableView.tableHeaderView = header
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "ContactsTableViewCell", bundle: nil) , forCellReuseIdentifier: "ContactsTableViewCell")
        // Do any additional setup after loading the view.
    }
}
extension TutorDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactsTableViewCell", for: indexPath) as! ContactsTableViewCell
        return cell
    }
}
