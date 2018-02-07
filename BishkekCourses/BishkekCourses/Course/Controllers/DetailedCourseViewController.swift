//
//  DetailedCourseViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/6/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import UIKit
import Moya_ModelMapper
import Moya
import PullToRefreshKit
class DetailedCourseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    private var cellId = "DescriptionTableViewCell"
    private var isFavorite = false
    private var course = DetailedCourse()
    private var isBottomPopupCompleted = true
    private let popupLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Номер скопирован."
        label.textColor = .white
        return label
    }()
    private let bottomPopupView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(netHex: Colors.darkPurple)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    var simpleCourse: SimpleCourse!
    override func viewDidLoad() {
        super.viewDidLoad()
        setSwipeLeftAction()
        configureTableView()
        setNavBarItems()
        getData()
        addPopupView()
    }
    func addPopupView() {
        bottomPopupView.addSubview(popupLabel)
        popupLabel.centerXAnchor.constraint(equalTo: bottomPopupView.centerXAnchor).isActive = true
        popupLabel.centerYAnchor.constraint(equalTo: bottomPopupView.centerYAnchor).isActive = true
        self.view.addSubview(bottomPopupView)
        //self.view.insertSubview(bottomPopupView, aboveSubview: tableView)
        bottomPopupView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomPopupView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomPopupView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bottomPopupView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        
        //view.bringSubview(toFront: bottomPopupView)
        //self.view.layoutSubviews()

    }
    func getData(){
        ServerAPIManager.sharedAPI.getCourseDetails(course_id: simpleCourse.id, setCourse, showError: showErrorAlert)
    }
    func setCourse(course: DetailedCourse){
        self.course = course
        self.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
        tableView.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
        self.navigationItem.title = simpleCourse.title
    }
    func setNavBarItems(){
        let backButton = UIButton.init(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(dissmis(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: getRightItem(image: #imageLiteral(resourceName: "bookmark")))
        //self.navigationItem.
        //self.navBar.setItems([navigationItem], animated: false)
    }
    @objc func dissmis(_ button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    @objc func favoritePressed(_ button: UIButton) {
        if !isFavorite {
            self.navigationController?.navigationBar.items![0].rightBarButtonItem?.customView = getRightItem(image: #imageLiteral(resourceName: "favorite_selected"))
        }
        else {
            self.navigationController?.navigationBar.items![0].rightBarButtonItem?.customView = getRightItem(image: #imageLiteral(resourceName: "bookmark"))
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
        addHeaderView()
        tableView.configRefreshHeader(with: getRefreshHeader(), action: { [weak self] in
            self?.getData()
        })
        
    }
    func addHeaderView(){
        let headerView = HeaderView()
        headerView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = headerView
        headerView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.tableView.widthAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: Constants.SCREEN_HEIGHT * 1 / 2).isActive = true
        tableView.layoutIfNeeded()
        headerView.menuBarView.cellDelegate = self
        tableView.tableHeaderView = tableView.tableHeaderView
        let mainImageUrl = URL(string: self.simpleCourse.main_image_url)
        headerView.mainImageView.kf.setImage(with: mainImageUrl)
        let logoImageUrl = URL(string: self.simpleCourse.logo_image_url)
        headerView.logoImageView.kf.setImage(with: logoImageUrl)
        headerView.titleLabel.text = self.simpleCourse.title
    }
    func registerCell(nibName: String){
        tableView.register(UINib.init(nibName: nibName, bundle: nil), forCellReuseIdentifier: nibName)
    }
}

extension DetailedCourseViewController: UITableViewDelegate, UITableViewDataSource, MenuBarDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        switch cellId {
        case "DescriptionTableViewCell":
            return 1
        case "CommentsTableViewCell":
            return 0
        case "BranchesTableViewCell":
            return course.branches.count
        case "ContactsTableViewCell":
            return course.contacts.count
        default:
            return course.services.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
            cell.fillCell(branch: course.branches[indexPath.row])
            return cell
        case "ContactsTableViewCell":
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ContactsTableViewCell
            cell.fillCell(contact: course.contacts[indexPath.row])
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! ServicesTableViewCell
            cell.fillCell(service: course.services[indexPath.row])
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch cellId {
            case "DescriptionTableViewCell":
                print("description")
            case "CommentsTableViewCell":
                print("comments")
            case "BranchesTableViewCell":
                print("branches")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                vc.branches = self.course.branches
                vc.branch_id = indexPath.row
                vc.branch_title = self.course.title
                //print(self.navigationController?.isNavigationBarHidden)
                self.navigationController?.show(vc, sender: self)
            case "ContactsTableViewCell":
                let contactType: ContactTypes = ContactTypes(rawValue: course.contacts[indexPath.row].type)!
                let contactValue = course.contacts[indexPath.row].contact
                switch contactType {
                case .EMAIL:
                    mailTo(mail: contactValue)
                case .PHONE:
                    callToPhone(number: contactValue)
                case .FACEBOOK, .WEBSITE:
                    openLink(link: contactValue)
                case .WHATSAPP:
                    copyNumber()
                }
            default:
                print("services")
            }
        }
    }
    private func copyNumber(){
        if isBottomPopupCompleted {
            UIView.animate(withDuration: 0.5, animations: {
                self.bottomPopupView.frame.origin.y -= 50
            }, completion: { (completed) in
                print(completed)
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        //self.bottomPopupView.alpha = 0
                        self.bottomPopupView.frame.origin.y += 50
                        //self.view.layoutIfNeeded()
                    }, completion: { (completed) in
                        self.isBottomPopupCompleted = true
                    })
                })
            })
            isBottomPopupCompleted = false
        }

    }
    private func openLink(link: String){
        if let url = URL(string: link) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:])
            } else {
                // Fallback on earlier versions
            }
        }
    }
    private func mailTo(mail: String){
        if let url = URL(string: "mailto:\(mail)") {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        }
    }
    
    private func callToPhone(number: String){
        let temp = self.returnNumber(number: number)
        if let url = NSURL(string: "telprompt:\(temp)"){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                
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
        tableView.reloadSections(IndexSet.init(integer: 0), with: .fade)
    }
    private func returnNumber(number: String) -> String {
        var ans = [Character]()
        for char in number {
            if ((String(char).rangeOfCharacter(from: CharacterSet.alphanumerics.inverted)) == nil) {
                ans.append(char)
            }
            else if (String(char) == "+"){
                ans.append(char)
            }
        }
        return String(ans)
    }
}

