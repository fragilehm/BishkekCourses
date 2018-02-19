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
import Hero
class CoursesBySubcategoryViewController: UIViewController {

    var panGR: UIPanGestureRecognizer!

    @IBOutlet weak var tableView: UITableView!
    var subcategory_id = 0
    var subcategoryName = ""
    var backImage = ""
    private var isCourse = true
    private var isBeganDismissing = false
    private var simpleCourses = [SimpleCourse]()
    private var backColor: UIColor?
    public let headerView: SubcategoryHeaderView = {
        let view = SubcategoryHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.back.addTarget(self, action: #selector(handleNext), for: .touchUpInside)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getData()
        addSwipeLeftAction()
        self.isHeroEnabled = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.heroNavigationAnimationType = .fade
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        UIApplication.shared.statusBarStyle = .lightContent
        guard let color = backColor else {
            UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
            return
        }
        UIApplication.shared.statusBarView?.backgroundColor = color
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.shared.statusBarStyle = .default
        UIApplication.shared.statusBarView?.backgroundColor = nil
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    func addSwipeLeftAction(){
        let swipeLeftGR = UIScreenEdgePanGestureRecognizer(target: self, action: #selector(swipeLeft(swipeRecognizer:)))
        swipeLeftGR.edges = .left
        self.view.addGestureRecognizer(swipeLeftGR)
    }
    @objc func swipeLeft(swipeRecognizer: UIScreenEdgePanGestureRecognizer){
        let translation = swipeRecognizer.translation(in: swipeRecognizer.view!.superview!)
        var progress = (translation.x / 200)
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        switch swipeRecognizer.state {
            
        case .began:
            print(translation.x)
            if translation.x >= 0{
                self.navigationController?.popViewController(animated: true)
            }
        case .changed:
            let viewPosition = CGPoint(x: view.center.x + translation.x,
                                       y: view.center.y)
            if  translation.x >= 0 {
                Hero.shared.update(progress)
                Hero.shared.apply(modifiers: [.position(viewPosition)], to: view)
            }
        default:
            if progress + swipeRecognizer.velocity(in: nil).x / view.bounds.width > 0.5 {
                Hero.shared.finish()
                
            } else {
                Hero.shared.cancel()
            }
        }

    }
    func addPanGR(){
        panGR = UIPanGestureRecognizer(target: self,
                                       action: #selector(handlePan(gestureRecognizer:)))
        headerView.blurView.addGestureRecognizer(panGR)
    }
    @objc func handlePan(gestureRecognizer:UIPanGestureRecognizer) {
        
        let translation = panGR.translation(in: panGR.view!.superview!)
        var progress = (translation.y / (view.bounds.height / 2))
        progress = CGFloat(fminf(fmaxf(Float(progress), 0.0), 1.0))
        switch panGR.state {
            
        case .began:
            if translation.y >= 0 {
                self.navigationController?.popViewController(animated: true)
            }
            isBeganDismissing = true
        case .changed:
            Hero.shared.update(progress)
            let viewPosition = CGPoint(x: view.center.x,
                                       y: translation.y + view.center.y)
            let imagePosition = CGPoint(x: headerView.backImageView.center.x,
                                        y: translation.y + headerView.backImageView.center.y)
            let namePosition = CGPoint(x: headerView.titleLabel.center.x,
                                       y: translation.y + headerView.titleLabel.center.y)
            let blurPosition = CGPoint(x: headerView.blurView.center.x,
                                       y: translation.y + headerView.blurView.center.y)
            if  translation.y > 0 {
                Hero.shared.apply(modifiers: [.position(imagePosition)], to: headerView.backImageView)
                Hero.shared.apply(modifiers: [.position(namePosition)], to: headerView.titleLabel)
                Hero.shared.apply(modifiers: [.position(blurPosition)], to: headerView.blurView)
                Hero.shared.apply(modifiers: [.position(viewPosition)], to: view)
            }
        default:
            if progress + panGR.velocity(in: nil).y / tableView.bounds.height > 0.3 {
                Hero.shared.finish()
            } else {
                Hero.shared.cancel()
                isBeganDismissing = false
            }
        }
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
        tableView.bounces = false
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
        let url = URL(string: backImage)
        headerView.backImageView.kf.setImage(with: url, placeholder: UIImage(named: "placeholder-image"), options: [], progressBlock: nil, completionHandler: nil)
        headerView.backImageView.heroID = "\(subcategoryName)_image"
        headerView.backImageView.heroModifiers = [.zPosition(2)]
        headerView.titleLabel.text = subcategoryName
        headerView.titleLabel.heroID = "\(subcategoryName)_name"
        headerView.titleLabel.heroModifiers = [.beginWith([.zPosition(10), .useGlobalCoordinateSpace])]
        headerView.blurView.heroID = "\(subcategoryName)_view"
        headerView.blurView.heroModifiers = [.zPosition(5)]
        self.tableView.tableHeaderView = headerView
        headerView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.tableView.widthAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: Constants.SCREEN_HEIGHT * 2 / 5).isActive = true
        self.tableView.tableHeaderView?.layoutIfNeeded()
        self.tableView.tableHeaderView = self.tableView.tableHeaderView
    }
    @objc private func handleNext(){
        self.navigationController?.popViewController(animated: true)
        Hero.shared.defaultAnimation = .auto
        Hero.shared.finish()
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
        let course = simpleCourses[indexPath.row]
        openCourse(id: course.id, name: course.title, logoUrl: course.logo_image_url, backUrl: course.main_image_url, description: course.description)
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
