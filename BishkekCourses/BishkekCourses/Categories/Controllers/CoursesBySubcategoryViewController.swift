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
    @IBOutlet weak var tipTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var tipTitleLabel: UILabel!
    @IBOutlet weak var tipDescriptionLabel: UILabel!
    @IBOutlet weak var tipView: UIView!
    @IBOutlet weak var tipTriangleView: TriangleView!
    var subcategory_id: Int?
    var cameFrom = CoursesBySubcategoryCameFrom.course
    var subcategoryName: String?
    var backImage: String?
    private var isCourse = true
    private var isBeganDismissing = false
    private var simpleCourses = [SimpleCourse]()
    private var simpleUniversities = [SimpleUniversity]()
    private var actions = [Promotion]()
    private var tutors = [Tutor]()
    private var typeOfDataToShow = CoursesBySubcategoryDataToShow.courses
    private var backColor: UIColor?
    private var isStatusBarClear = true
    public let headerView: SubcategoryHeaderView = {
        let view = SubcategoryHeaderView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.back.addTarget(self, action: #selector(handlePrevious), for: .touchUpInside)
        return view
    }()
    private let tipHideButton: UIButton = {
        let button = UIButton.init(type: .system)
        button.backgroundColor = .black
        button.alpha = 0.5
        button.addTarget(self, action: #selector(hideTipTap), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBasic()
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
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        checkForTip()
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
    func checkForTip(){
        let tipModel = TipStorage()
        if !tipModel.isTipShowed() && cameFrom == .course {
            tipModel.setTipShowed()
            tipTitleLabel.text = tipModel.tipTitle
            tipDescriptionLabel.text = tipModel.tipDescription
            self.tipTopConstraint.constant = 0
            self.tipHideButton.alpha = 0.5
            UIView.animate(withDuration: 0.5, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    @objc func hideTipTap(_ sender: UIButton){
        self.hideTip()
    }
    @IBAction func hideTipButtonTap(_ sender: Any) {
        self.hideTip()
    }
    fileprivate func hideTip() {
        self.tipTopConstraint.constant = -300
        self.tipHideButton.alpha = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
    }
    func configureBasic() {
        self.tipHideButton.frame = self.view.frame
        self.tipHideButton.alpha = 0
        self.view.insertSubview(tipHideButton, aboveSubview: tableView)
    }
    func configureTableView(){
        if getDeviceName() == Devices.IPHONE_5_8 {
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -44).isActive = true
        }
        else {
            self.tableView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: -20).isActive = true
        }
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: Constants.Categories.CellID.COURSES_BY_SUBCATEGORY_TABLEVIEW_CELL, bundle: nil), forCellReuseIdentifier: Constants.Categories.CellID.COURSES_BY_SUBCATEGORY_TABLEVIEW_CELL)
        tableView.register(UINib.init(nibName: Constants.Promotions.CellID.PROMOTION_TABLEVIEW_CELL, bundle: nil), forCellReuseIdentifier: Constants.Promotions.CellID.PROMOTION_TABLEVIEW_CELL)
        tableView.register(UINib.init(nibName: Constants.Tutor.CellID.TUTOR_TABLEVIEW_CELL, bundle: nil), forCellReuseIdentifier: Constants.Tutor.CellID.TUTOR_TABLEVIEW_CELL)
        tableView.estimatedRowHeight = UITableViewAutomaticDimension
        tableView.bounces = false
        addHeaderView()
    }
    func addHeaderView() {
        let url = URL(string: backImage!)
        headerView.backImageView.kf.setImage(with: url, placeholder: Constants.PLACEHOLDER_IMAGE, options: [], progressBlock: nil, completionHandler: nil)
        headerView.titleLabel.text = subcategoryName
        if cameFrom == .university {
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
        
        let alertController = UIAlertController(title: Constants.Categories.CoursesBySubcategory.ActionSheetText.TITLE, message: nil, preferredStyle: .actionSheet)
        let courseButton = UIAlertAction(title: Constants.Categories.CoursesBySubcategory.ActionSheetTitle.COURSES, style: .default) { (action) in
            self.typeOfDataToShow = CoursesBySubcategoryDataToShow.courses
            self.getData()
        }
        let actionButton = UIAlertAction(title: Constants.Categories.CoursesBySubcategory.ActionSheetTitle.ACTIONS, style: .default) { (action) in
            self.typeOfDataToShow = CoursesBySubcategoryDataToShow.actions
            self.getData()
        }
        let tutorButton = UIAlertAction(title: Constants.Categories.CoursesBySubcategory.ActionSheetTitle.TUTORS, style: .default) { (action) in
            self.typeOfDataToShow = CoursesBySubcategoryDataToShow.tutors
            self.getData()
        }
        let cancelButton = UIAlertAction(title: Constants.Categories.CoursesBySubcategory.ActionSheetText.CANCEL, style: .cancel, handler: nil)
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
        case .courses:
            switch cameFrom {
            case .university:
                ServerAPIManager.sharedAPI.getUniversitiesByCategory(category_id: self.subcategory_id!, setUniversities, showError: showErrorAlert)
            case .course:
                    ServerAPIManager.sharedAPI.getCoursesBySubcategory(subcategory_id: self.subcategory_id!, setCourses, showError: showErrorAlert)
            }
        case .actions:
            ServerAPIManager.sharedAPI.getActionsBySubcategory(subcategory_id: self.subcategory_id!, setActions, showError: showErrorAlert)
        case .tutors:
            ServerAPIManager.sharedAPI.getTutorsBySubcategory(subcategory_id: self.subcategory_id!, setTutors, showError: showErrorAlert)
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
        case .courses:
            return cameFrom == .course ? simpleCourses.count : simpleUniversities.count
        case .actions:
            return actions.count
        case .tutors:
            return tutors.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch typeOfDataToShow {
        case .courses:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Categories.CellID.COURSES_BY_SUBCATEGORY_TABLEVIEW_CELL, for: indexPath) as! CoursesBySubcategoryTableViewCell
            switch cameFrom {
            case .course:
                let course = simpleCourses[indexPath.row]
                cell.fillCell(title: course.title, description: course.description, logo_image_url: course.logo_image_url, main_image_url: course.main_image_url)
            case .university:
                let university = simpleUniversities[indexPath.row]
                cell.fillCell(title: university.title, description: university.description, logo_image_url: university.logo_image_url, main_image_url: university.main_image_url)
            }
            return cell
        case .actions:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Promotions.CellID.PROMOTION_TABLEVIEW_CELL, for: indexPath) as! PromotionTableViewCell
            cell.fillCell(action: self.actions[indexPath.row], index: indexPath.row)
            cell.delegate = self
            return cell
        case .tutors:
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
        case .courses:
            switch cameFrom {
            case .course:
                let course = simpleCourses[indexPath.row]
                openCourse(id: course.id, name: course.title, logoUrl: course.logo_image_url, backUrl: course.main_image_url, description: course.description)
            case .university:
                let university = simpleUniversities[indexPath.row]
                let courseVC = UIStoryboard.init(name: Constants.Storyboards.COURSE, bundle: nil).instantiateViewController(withIdentifier: Constants.DetailedCourse.ControllerID.DETAILED_COURSE_VIEWCONTROLLER
                    ) as! DetailedCourseViewController
                courseVC.courseName = university.title
                courseVC.courseBackImage = university.main_image_url
                courseVC.courseLogo = university.logo_image_url
                courseVC.course_id = university.id
                courseVC.cameFrom = .university
                courseVC.courseDescription = university.description
                self.navigationController?.show(courseVC, sender: self)
            }
            
        case .actions:
            let storyboard = UIStoryboard.init(name: Constants.Storyboards.PROMOTION, bundle: nil)
            let promotionVC = storyboard.instantiateViewController(withIdentifier: Constants.Promotions.ControllerID.PROMOTIONS_DETAIL_VIEWCONTROLLER) as! PromotionsDetailViewController
            let action = self.actions[indexPath.row]
            let simpleAction = SimplePromotion(id: action.id, title: action.title, description: action.description, end_date: action.end_date!, action_image: action.action_image)
            promotionVC.courseHeader = self.actions[indexPath.row].course
            promotionVC.simpleAction = simpleAction
            self.navigationController?.show(promotionVC, sender: self)
        case .tutors:
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
