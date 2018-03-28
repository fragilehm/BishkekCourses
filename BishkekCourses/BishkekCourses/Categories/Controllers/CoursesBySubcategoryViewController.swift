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
    var cameFrom = "subcategories"
    var subcategoryName = ""
    var backImage = ""
    private var isCourse = true
    private var isBeganDismissing = false
    private var simpleCourses = [SimpleCourse]()
    private var simpleUniversities = [SimpleUniversity]()
    private var actions = [Promotion]()
    private var tutors = [Tutor]()
    private var typeOfDataToShow = "courses"
    private var backColor: UIColor?
    private var isStatusBarClear = true
    public let headerView: SubcategoryHeaderView = {
        let view = SubcategoryHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.back.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        getData()
        
        self.isHeroEnabled = true
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.setTabBarVisible(visible: true, animated: false)
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        UIApplication.shared.statusBarStyle = .lightContent
        guard let color = backColor else {
            UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
            return
        }
        UIApplication.shared.statusBarView?.backgroundColor = color
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.tabBarController?.setTabBarVisible(visible: true, animated: true)
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        UIApplication.shared.statusBarStyle = .default
        UIView.animate(withDuration: TimeInterval(UINavigationControllerHideShowBarDuration)) {
            UIApplication.shared.statusBarView?.backgroundColor = nil
        }
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
            self.hero_dismissViewController()
        case .changed:
            let viewPosition = CGPoint(x: view.center.x + translation.x,
                                       y: view.center.y)
            Hero.shared.update(progress)
            Hero.shared.apply(modifiers: [.position(viewPosition)], to: view)
        default:
            if progress + swipeRecognizer.velocity(in: nil).x / view.bounds.width > 1 {
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
        if getDeviceName() == Constants.Devices.IPHONE_5_8 {
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -44).isActive = true
        }
        else {
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -20).isActive = true
        }
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: Constants.Categories.CellID.COURSES_BY_SUBCATEGORY_TABLEVIEW_CELL, bundle: nil), forCellReuseIdentifier: Constants.Categories.CellID.COURSES_BY_SUBCATEGORY_TABLEVIEW_CELL)
        tableView.register(UINib.init(nibName: Constants.Promotions.CellID.NEWS_TABLEVIEW_CELL, bundle: nil), forCellReuseIdentifier: Constants.Promotions.CellID.NEWS_TABLEVIEW_CELL)
        tableView.register(UINib.init(nibName: Constants.Tutor.CellID.TUTOR_TABLEVIEW_CELL, bundle: nil), forCellReuseIdentifier: Constants.Tutor.CellID.TUTOR_TABLEVIEW_CELL)
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.bounces = false
        addHeaderView()
    }
    func addHeaderView() {
        let url = URL(string: backImage)
        headerView.backImageView.kf.setImage(with: url, placeholder: Constants.PLACEHOLDER_IMAGE, options: [], progressBlock: nil, completionHandler: nil)
        //        headerView.backImageView.heroID = "\(subcategoryName)_image"
        //        headerView.backImageView.heroModifiers = [.zPosition(2)]
        //        headerView.titleLabel.heroID = "\(subcategoryName)_name"
        //        headerView.titleLabel.heroModifiers = [.beginWith([.zPosition(10), .useGlobalCoordinateSpace])]
        //        headerView.blurView.heroID = "\(subcategoryName)_view"
        //        headerView.blurView.heroModifiers = [.zPosition(5)]
        headerView.titleLabel.text = subcategoryName
        if cameFrom == "categories" {
            headerView.actionCourseButton.isHidden = true
        }
        headerView.actionCourseButton.addTarget(self, action: #selector(actionList), for: .touchUpInside)
        self.tableView.tableHeaderView = headerView
        headerView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.tableView.widthAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: Constants.SCREEN_HEIGHT * 2 / 5).isActive = true
        self.tableView.tableHeaderView?.layoutIfNeeded()
        self.tableView.tableHeaderView = self.tableView.tableHeaderView
    }
    @objc private func actionList(){
        
        let alertController = UIAlertController(title: "Выберите тип", message: nil, preferredStyle: .actionSheet)
        let courseButton = UIAlertAction(title: "Курсы", style: .default) { (action) in
            self.typeOfDataToShow = "courses"
            self.getData()
        }
        let actionButton = UIAlertAction(title: "Акции", style: .default) { (action) in
            self.typeOfDataToShow = "actions"
            self.getData()
        }
        let tutorButton = UIAlertAction(title: "Репетиторы", style: .default) { (action) in
            self.typeOfDataToShow = "tutor"
            self.getData()
        }
        let cancelButton = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        alertController.addAction(courseButton)
        alertController.addAction(actionButton)
        alertController.addAction(tutorButton)
        alertController.addAction(cancelButton)
        alertController.popoverPresentationController?.sourceView = self.view
        self.present(alertController, animated: true, completion: nil)
    }
    @objc private func handlePrevious(){
        self.hero_dismissViewController()
        Hero.shared.defaultAnimation = .auto
    }
    func getData() {
        switch typeOfDataToShow {
        case "courses":
            if cameFrom == "categories" {
                ServerAPIManager.sharedAPI.getUniversitiesByCategory(category_id: self.subcategory_id, setUniversities, showError: showErrorAlert)
            }
            else {
                ServerAPIManager.sharedAPI.getCoursesBySubcategory(subcategory_id: self.subcategory_id, setCourses, showError: showErrorAlert)
            }

        case "actions":
            ServerAPIManager.sharedAPI.getActionsBySubcategory(subcategory_id: self.subcategory_id, setActions, showError: showErrorAlert)
        default:
            ServerAPIManager.sharedAPI.getTutorsBySubcategory(subcategory_id: self.subcategory_id, setTutors, showError: showErrorAlert)
        }
        //self.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
    }
    func setTutors(tutors: [Tutor]) {
        self.tutors = tutors
        reloadData()
        
    }
    func setCourses(courses: [SimpleCourse]){
        
        self.simpleCourses = courses
        reloadData()

        //self.collectionView.switchRefreshHeader(to: .normal(.none, 0.0))
    }
    func setUniversities(universities: [SimpleUniversity]){
        self.simpleUniversities = universities
        reloadData()
        //self.collectionView.switchRefreshHeader(to: .normal(.none, 0.0))
    }
    func setActions(actions: [Promotion]) {
        self.actions = actions
        reloadData()
    }
    func reloadData(){
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
            //self.tableView.switchRefreshFooter(to: .normal)
        })
        
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
        switch typeOfDataToShow {
        case "courses":
            return cameFrom == "subcategories" ? simpleCourses.count : simpleUniversities.count
        case "actions":
            return actions.count
        default:
            return tutors.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch typeOfDataToShow {
        case "courses":
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Categories.CellID.COURSES_BY_SUBCATEGORY_TABLEVIEW_CELL, for: indexPath) as! CoursesBySubcategoryTableViewCell
            if cameFrom == "subcategories" {
                let course = simpleCourses[indexPath.row]
                cell.fillCell(title: course.title, description: course.description, logo_image_url: course.logo_image_url, main_image_url: course.main_image_url)
            }
            else {
                let university = simpleUniversities[indexPath.row]
                cell.fillCell(title: university.title, description: university.description, logo_image_url: university.logo_image_url, main_image_url: university.main_image_url)
            }
            return cell
        case "actions":
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Promotions.CellID.NEWS_TABLEVIEW_CELL, for: indexPath) as! NewsTableViewCell
            cell.fillCell(action: self.actions[indexPath.row], index: indexPath.row)
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Tutor.CellID.TUTOR_TABLEVIEW_CELL, for: indexPath) as! TutorTableViewCell
            cell.fillCell(tutor: self.tutors[indexPath.row])
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch typeOfDataToShow {
        case "courses":
            
            if cameFrom == "subcategories" {
                let course = simpleCourses[indexPath.row]
                openCourse(id: course.id, name: course.title, logoUrl: course.logo_image_url, backUrl: course.main_image_url, description: course.description)
            } else {
                let university = simpleUniversities[indexPath.row]
                let courseVC = UIStoryboard.init(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "DetailedCourseViewController") as! DetailedCourseViewController
                courseVC.courseName = university.title
                courseVC.courseBackImage = university.main_image_url
                courseVC.courseLogo = university.logo_image_url
                courseVC.course_id = university.id
                courseVC.cameFrom = "universitySubcategories"
                courseVC.courseDescription = university.description
                self.navigationController?.show(courseVC, sender: self)
            }
            
        case "actions":
            let storyboard = UIStoryboard.init(name: Constants.Storyboards.NEWS, bundle: nil)
            let promotionVC = storyboard.instantiateViewController(withIdentifier: Constants.Promotions.ControllerID.PROMOTIONS_DETAIL_VIEWCONTROLLER) as! PromotionsDetailViewController
            let action = self.actions[indexPath.row]
            let simpleAction = SimplePromotion(id: action.id, title: action.title, description: action.description, end_date: action.end_date, action_image: action.action_image)
            promotionVC.courseHeader = self.actions[indexPath.row].course
            promotionVC.simpleAction = simpleAction
            self.navigationController?.show(promotionVC, sender: self)
        default:
            let storyboard = UIStoryboard.init(name: Constants.Storyboards.TUTOR, bundle: nil)
            let tutorVC = storyboard.instantiateViewController(withIdentifier: Constants.Tutor.ControllerID.TUTOR_DETAIL_VIEWCONTROLLER) as! TutorDetailViewController
            tutorVC.tutor = self.tutors[indexPath.row]
            self.navigationController?.show(tutorVC, sender: self)
            
        }
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 84 {
           if isStatusBarClear {
                UIView.animate(withDuration: 0.5, animations: {
                    UIApplication.shared.statusBarView?.backgroundColor = UIColor.black
                })
                backColor = UIColor.black
                isStatusBarClear = false
           }
        }
        else
        {
           if !isStatusBarClear {
                UIView.animate(withDuration: 0.5, animations: {
                    UIApplication.shared.statusBarView?.backgroundColor = UIColor.clear
                })
                backColor = UIColor.clear
                isStatusBarClear = true
            }
        }
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0){
            self.tabBarController?.setTabBarVisible(visible:false, animated: true)
        }else{
            self.tabBarController?.setTabBarVisible(visible: true, animated: true)
        }
    }
}
extension CoursesBySubcategoryViewController: ActionsTableViewCellDelegate {
    func ActionsTableViewCellDidTapCourse(_ row: Int) {
        let course = actions[row].course
        openCourse(id: course.id, name: course.title, logoUrl: course.logo_image_url, backUrl: course.main_image_url, description: course.description)
    }
}
