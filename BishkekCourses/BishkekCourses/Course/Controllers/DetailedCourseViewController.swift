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
import Hero
class DetailedCourseViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var panGR: UIPanGestureRecognizer!

    private var cellId = DetailedCourseCellId.description
    private var isFavorite = false
    private var course = DetailedCourse()
    private var isBottomPopupCompleted = true
    var course_id: Int?
    var courseName: String?
    var courseBackImage: String?
    var courseLogo: String?
    var courseDescription: String?
    var cameFrom = CoursesBySubcategoryCameFrom.course
    private let headerView = HeaderView()
    private let popupLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Номер скопирован."
        label.textColor = .white
        return label
    }()
    private let bottomPopupView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(netHex: Colors.DARK_PURPLE)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTableView()
        setNavBarItems()
        getData()
        setupPopupView()
        self.navigationController?.heroNavigationAnimationType = .fade
        self.isHeroEnabled = true
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.setTabBarVisible(visible: true, animated: false)
        self.navigationItem.title = courseName
    }
    override func viewWillDisappear(_ animated: Bool) {
        self.tabBarController?.setTabBarVisible(visible: true, animated: true)
    }
   
    func setupPanGesture(){
        panGR = UIPanGestureRecognizer(target: self,
                                       action: #selector(handlePan(gestureRecognizer:)))
        view.addGestureRecognizer(panGR)
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
    
    @objc func handlePan(gestureRecognizer:UIPanGestureRecognizer) {
        switch panGR.state {
        case .began:
            // begin the transition as normal
            dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    func setupPopupView() {
        bottomPopupView.addSubview(popupLabel)
        self.view.addSubview(bottomPopupView)
        NSLayoutConstraint.activate([
            popupLabel.centerXAnchor.constraint(equalTo: bottomPopupView.centerXAnchor),
            popupLabel.centerYAnchor.constraint(equalTo: bottomPopupView.centerYAnchor),
            bottomPopupView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            bottomPopupView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bottomPopupView.heightAnchor.constraint(equalToConstant: 50),
            bottomPopupView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
            ])
    }
    func getData(){
        switch cameFrom {
        case .course:
            ServerAPIManager.sharedAPI.getCourseDetails(course_id: course_id!, setCourse, showError: showErrorAlert)
        case .university:
            ServerAPIManager.sharedAPI.getUniversityDetails(university_id: course_id!, setUniversity, showError: showErrorAlert)
        }
    }
    func setUniversity(university: DetailedCourse){
        self.course = university
        print(university)
        self.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
        tableView.reloadData()
    }
    func setCourse(course: DetailedCourse){
        self.course = course
        self.tableView.switchRefreshHeader(to: .normal(.none, 0.0))
        tableView.reloadData()
    }
    func setHeaderData(main: String, logo: String, title: String){
                
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
        registerCell(nibName: Constants.DetailedCourse.CellID.HEADER_TABLEVIEW_CELL)
        registerCell(nibName: Constants.DetailedCourse.CellID.COURSE_ACTION_TABLEVIEW_CELL)
        registerCell(nibName: Constants.DetailedCourse.CellID.COMMENTS_TABLEVIEW_CELL)
        registerCell(nibName: Constants.DetailedCourse.CellID.SERVICES_TABLEVIEW_CELL)
        registerCell(nibName: Constants.DetailedCourse.CellID.BRANCHES_TABLEVIEW_CELL)
        registerCell(nibName: Constants.DetailedCourse.CellID.CONTATCS_TABLEVIEW_CELL)
        registerCell(nibName: Constants.DetailedCourse.CellID.DESCRIPTION_TABLEVIEW_CELL)
        registerCell(nibName: Constants.DetailedCourse.CellID.DEPARTMENT_TABLEVIEW_CELL)
        registerCell(nibName: Constants.DetailedCourse.CellID.GRANT_TABLEVIEW_CELL)

        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        addHeaderView()
        tableView.configureRefreshHeader {
            self.getData()
        }
        
    }
    func addHeaderView(){
        setupHeaderView()
        tableView.layoutIfNeeded()
        headerView.menuBarView.cellDelegate = self
        tableView.tableHeaderView = tableView.tableHeaderView
        let mainImageUrl = URL(string: courseBackImage!)
        headerView.mainImageView.kf.setImage(with: mainImageUrl)
        headerView.mainImageView.heroID = "\(courseName!)_image"
        headerView.mainImageView.heroModifiers = [.zPosition(2)]
        headerView.logoImageView.heroID = "\(courseName!)_logo"
        headerView.logoImageView.heroModifiers = [.beginWith([.zPosition(5), .useGlobalCoordinateSpace])]
        headerView.titleLabel.heroID = "\(courseName!)_name"
        headerView.titleLabel.heroModifiers = [.zPosition(10)]
        let logoImageUrl = URL(string: courseLogo!)
        headerView.logoImageView.kf.setImage(with: logoImageUrl)
        headerView.titleLabel.text = courseName
    }
    func setupHeaderView() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = headerView
        NSLayoutConstraint.activate([
            headerView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor),
            headerView.widthAnchor.constraint(equalTo: self.tableView.widthAnchor),
            headerView.topAnchor.constraint(equalTo: self.tableView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: Constants.SCREEN_HEIGHT * 1 / 2)
            ])
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
        case .description:
            return 1
        case .actions:
            guard let actions = course.actions else {
                return 0
            }
            return actions.count
        case .grants:
            guard let grants = course.grants else {
                return 0
            }
            return grants.count
        case .branches:
            return course.branches.count
        case .contacts:
            return course.contacts.count
        default:
            return cameFrom == .course ? course.services!.count : course.departments!.count
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch cellId {
        case .description:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId.rawValue, for: indexPath) as!
            DescriptionTableViewCell
            cell.fillCell(description: courseDescription!)
            return cell
        case .actions:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId.rawValue, for: indexPath) as!
            CourseActionTableViewCell
            cell.fillCell(action: course.actions![indexPath.row])
            return cell
        case .grants:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId.rawValue, for: indexPath) as!
            GrantTableViewCell
            cell.fillCell(action: course.grants![indexPath.row])
            return cell
        case .branches:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId.rawValue, for: indexPath) as! BranchesTableViewCell
            cell.fillCell(branch: course.branches[indexPath.row])
            return cell
        case .contacts:
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId.rawValue, for: indexPath) as! ContactsTableViewCell
            cell.fillCell(contact: course.contacts[indexPath.row])
            return cell
        default:
            switch cameFrom {
            case .course:
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId.rawValue, for: indexPath) as! ServicesTableViewCell
                cell.fillCell(service: course.services![indexPath.row])
                return cell
            case .university:
                let cell = tableView.dequeueReusableCell(withIdentifier: cellId.rawValue, for: indexPath) as! DepartmentTableViewCell
                cell.fillCell(department: course.departments![indexPath.row])
                return cell
            }
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            switch cellId {
            case .actions:
                showActionController(index: indexPath.row)
            case .grants:
                showGrantController(index: indexPath.row)
            case .branches:
                showBranchController(index: indexPath.row)
            case .contacts:
                contactAction(index: indexPath.row)
            default:
                print("services and decription")
            }
        }
    }
    fileprivate func showActionController(index: Int) {
        let promotionVC = UIStoryboard.init(name: Constants.Storyboards.PROMOTION, bundle: nil).instantiateViewController(withIdentifier: Constants.Promotions.ControllerID.PROMOTIONS_DETAIL_VIEWCONTROLLER) as! PromotionsDetailViewController
        let courseHeader = CourseHeader(id: course_id!, title: courseName!, logo_image_url: courseLogo!, main_image_url: courseBackImage!, description: courseDescription!)
        promotionVC.courseHeader = courseHeader
        promotionVC.simpleAction = course.actions![index]
        promotionVC.isFromCourse = true
        self.navigationController?.show(promotionVC, sender: self)
    }
    fileprivate func showGrantController(index: Int) {
        let grantVC = UIStoryboard.init(name: Constants.Storyboards.GRANTS, bundle: nil).instantiateViewController(withIdentifier: Constants.Grants.ControllerID.GRANT_DETAIL_VIEWCONTROLLER) as! GrantDetailViewController
        let universityHeader = CourseHeader(id: course_id!, title: courseName!, logo_image_url: courseLogo!, main_image_url: courseBackImage!, description: courseDescription!)
        grantVC.universityHeader = universityHeader
        grantVC.simpleGrant = course.grants![index]
        grantVC.isFromCourse = true
        self.navigationController?.show(grantVC, sender: self)
    }
    fileprivate func showBranchController(index: Int) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: Constants.DetailedCourse.ControllerID.MAP_VIEWCONTROLLER) as! MapViewController
        vc.branches = self.course.branches
        vc.branch_id = index
        vc.branch_title = self.course.title
        self.navigationController?.show(vc, sender: self)
    }
    fileprivate func contactAction(index: Int) {
        DispatchQueue.main.async(execute: {
            let contactType: ContactTypes = ContactTypes(rawValue: self.course.contacts[index].type)!
            let contactValue = self.course.contacts[index].contact
            switch contactType {
            case .EMAIL:
                contactValue.mailTo(controller: self)
            case .PHONE:
                contactValue.callToPhone()
            case .FACEBOOK, .WEBSITE:
                contactValue.openLink(controller: self)
            case .WHATSAPP:
                self.copyNumber(number: contactValue)
            case .INSTAGRAM:
                var profileLogin = contactValue
                profileLogin.remove(at: profileLogin.startIndex)
                let fullLink = "\(Constants.DetailedCourse.INSTAGRAM_LINK)\(profileLogin)"
                fullLink.openLink(controller: self)
            }
        })
    }
    fileprivate func copyNumber(number: String){
        if isBottomPopupCompleted {
            let offset = self.view.frame.height - (self.tabBarController?.tabBar.frame.origin.y)!
            UIPasteboard.general.string = number.returnNumber()
            UIView.animate(withDuration: 0.5, animations: {
                self.bottomPopupView.frame.origin.y -= (50 + offset)
            }, completion: { (completed) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        self.bottomPopupView.frame.origin.y += (50 + offset)
                    }, completion: { (completed) in
                        self.isBottomPopupCompleted = true
                    })
                })
            })
            isBottomPopupCompleted = false
        }
    }
    
    
    func iconPressed(_ index: Int) {
        
        switch index {
        case 0:
            cellId = .description
        case 1:
            switch cameFrom {
            case .course:
                cellId = .actions
            case .university:
                cellId = .grants
            }
        case 2:
            cellId = .branches
        case 3:
            cellId = .contacts
        default:
            switch cameFrom {
            case .course:
                cellId = .services
            case .university:
                cellId = .departments
            }
        }
        tableView.reloadSections(IndexSet.init(integer: 0), with: .fade)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0){
            self.tabBarController?.setTabBarVisible(visible:false, animated: true)
        }else{
            self.tabBarController?.setTabBarVisible(visible: true, animated: true)
        }
    }
}

