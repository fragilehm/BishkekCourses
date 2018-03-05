//
//  SettingsViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/28/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
import HGPlaceholders
class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: TableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        // Do any additional setup after loading the view.
    }
}
extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 1 : section == 1 ? Constants.SETTINGS_TITLES.count : 1
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Settings.CellID.PROFILE_TABLEVIEW_CELL, for: indexPath) as! ProfileTableViewCell
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Settings.CellID.SETTINGS_TABLEVIEW_CELL, for: indexPath) as! SettingsTableViewCell
            cell.separatorInset = UIEdgeInsetsMake(0, 52, 0, 0)
            cell.settingsTitleLabel.text = Constants.SETTINGS_TITLES[indexPath.row]
            cell.settingsImageView.image = UIImage(named: Constants.SETTINGS_IMAGES[indexPath.row])
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Settings.CellID.LOGOUT_TABLEVIEW_CELL, for: indexPath) as! LogoutTableViewCell
            cell.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0)
            cell.logoutLabel.text = Constants.Settings.LOGOUT_TEXT
            return cell
        }
       
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        view.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 40)
//
//        let topView = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 0.4))
//        topView.backgroundColor = UIColor.lightGray
//        view.addSubview(topView)
//        let bottomView = UIView(frame: CGRect(x: 0, y: 39.5, width: self.tableView.bounds.width, height: 0.4))
//        bottomView.backgroundColor = UIColor.lightGray
//        view.addSubview(bottomView)
////        let label = UILabel(frame: CGRect(x: 16, y: 25, width: self.tableView.bounds.width - 10, height: 20))
////        view.addSubview(label)
////        label.font = UIFont.systemFont(ofSize: 14)
////        label.textColor = UIColor.darkGray
////        label.text = Constants.TUTOR_HEADERS[section]
//        view.backgroundColor = UIColor.groupTableViewBackground
//        return view
//    }
//    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
//
//        return section == 0 ? 0 : 40
//    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let storyboard = UIStoryboard.init(name: Constants.Storyboards.LOGIN, bundle: nil)
            let loginVC = storyboard.instantiateViewController(withIdentifier: Constants.Login.ControllerID.LOGIN_MAIN_VIEWCONTROLLER)
            let nav = UINavigationController(rootViewController: loginVC)
            self.navigationController?.present(nav, animated: false, completion: nil)
        }
    }
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableViewAutomaticDimension
//    }
}

extension SettingsViewController {
    func configureTableView() {
        self.tableView.tableFooterView = UIView()
        self.tableView.register(UINib.init(nibName: Constants.Settings.CellID.SETTINGS_TABLEVIEW_CELL, bundle: nil), forCellReuseIdentifier: Constants.Settings.CellID.SETTINGS_TABLEVIEW_CELL)
        self.tableView.register(UINib.init(nibName: Constants.Settings.CellID.PROFILE_TABLEVIEW_CELL, bundle: nil), forCellReuseIdentifier: Constants.Settings.CellID.PROFILE_TABLEVIEW_CELL)
        self.tableView.register(UINib.init(nibName: Constants.Settings.CellID.LOGOUT_TABLEVIEW_CELL, bundle: nil), forCellReuseIdentifier: Constants.Settings.CellID.LOGOUT_TABLEVIEW_CELL)
//        tableView.placeholdersProvider = .summer
//        let key = PlaceholderKey.custom(key: "starWars")
//        tableView?.showCustomPlaceholder(with: key)
    }
}
