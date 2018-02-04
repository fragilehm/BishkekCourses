//
//  CoursesBySubcategoryViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/3/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
import Moya
import PullToRefreshKit
import HGPlaceholders
class CoursesBySubcategoryViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var subcategory_id = 0
    var subcategoryName = ""
    var backImage = ""
    private var simpleCourses = [SimpleCourse]()
    private var backColor: UIColor?
    private let backImageView: UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "coding").withRenderingMode(.alwaysOriginal))
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    private let contentView: UIView = {
        let containerView = UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    private let back: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        button.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        button.setImage(#imageLiteral(resourceName: "back-white").withRenderingMode(.alwaysOriginal), for: .normal)
        return button
    }()
    private let blurView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 19)
        label.textColor = .white
        label.numberOfLines = 1
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //setNavBarItems()
        configureTableView()
        getData()
 
    }
    func configureTableView(){
        if getDeviceName() == "iPhone 5.8" {
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -44).isActive = true
        }
        else {
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -20).isActive = true
        }
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: "CoursesBySubcategoryTableViewCell", bundle: nil), forCellReuseIdentifier: "CoursesBySubcategoryTableViewCell")
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        //tableView.bounces = false
//        let header = DefaultRefreshHeader.header()
//        header.setText(Constants.Hint.Refresh.pull_to_refresh, mode: .pullToRefresh)
//        header.setText(Constants.Hint.Refresh.relase_to_refresh, mode: .releaseToRefresh)
//        header.setText(Constants.Hint.Refresh.success, mode: .refreshSuccess)
//        header.setText(Constants.Hint.Refresh.refreshing, mode: .refreshing)
//        header.setText(Constants.Hint.Refresh.failed, mode: .refreshFailure)
//        header.imageRenderingWithTintColor = true
//        header.durationWhenHide = 0.4
//        tableView.configRefreshHeader(with: header, action: { [weak self] in
//            self?.getData()
//        })
        addHeaderView()
    }
    func addHeaderView() {
        contentView.addSubview(backImageView)
        contentView.addSubview(blurView)
        contentView.addSubview(back)
        contentView.addSubview(titleLabel)
        let url = URL(string: backImage)
        backImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
        titleLabel.text = subcategoryName
        blurView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        blurView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        blurView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        blurView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 16).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16).isActive = true
        var backButtonTopConstraint = 32
        if self.getDeviceName() == "iPhone 5.8" {
            backButtonTopConstraint = 56
        }
        back.topAnchor.constraint(equalTo: contentView.topAnchor, constant: CGFloat(backButtonTopConstraint)).isActive = true
        back.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        backImageView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        backImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        backImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        backImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        self.tableView.tableHeaderView = contentView
        contentView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: self.tableView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
        contentView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.height * 2 / 5).isActive = true
        self.tableView.tableHeaderView?.layoutIfNeeded()
        self.tableView.tableHeaderView = self.tableView.tableHeaderView
    }
    @objc private func handleNext(){
        self.navigationController?.popViewController(animated: true)
    }
    func getData() {
        ServerAPIManager.sharedAPI.getCoursesBySubcategory(subcategory_id: self.subcategory_id, setCourses, showError: showErrorAlert)
        //self.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
    }
    func setCourses(courses: [SimpleCourse]){
        self.simpleCourses = courses
        self.tableView.reloadData()
        //self.collectionView.switchRefreshHeader(to: .normal(.none, 0.0))
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
        UIApplication.shared.statusBarStyle = .lightContent
        guard let color = backColor else {
            UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
            return
        }
        UIApplication.shared.statusBarView?.backgroundColor = color
    }
    override func viewWillDisappear(_ animated: Bool) {
        UIApplication.shared.statusBarStyle = .default
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.isHidden = false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func setNavBarItems(){
        let backButton = UIButton.init(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(dissmis(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    @objc func dissmis(_ button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

extension CoursesBySubcategoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return simpleCourses.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CoursesBySubcategoryTableViewCell", for: indexPath) as! CoursesBySubcategoryTableViewCell
        cell.fillCell(course: self.simpleCourses[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Course", bundle: nil)
        let courseVC = storyboard.instantiateViewController(withIdentifier: "DetailedCourseViewController") as! DetailedCourseViewController
        courseVC.simpleCourse = simpleCourses[indexPath.row]
        self.navigationController?.show(courseVC, sender: self)
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 84 {
            UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
            backColor = UIColor.black
        }
        else
        {
            UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
            backColor = UIColor.clear
        }
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        tableView.reloadData()
    }
    
}
