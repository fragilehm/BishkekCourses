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

    private var cellId = "DescriptionTableViewCell"
    private var isFavorite = false
    private var course = DetailedCourse()
    private var isBottomPopupCompleted = true
    var course_id = 0
    var courseName = ""
    var courseBackImage = ""
    var courseLogo = ""
    var courseDescription = ""
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
        view.backgroundColor = UIColor(netHex: Colors.darkPurple)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        //setSwipeLeftAction()
        configureTableView()
        setNavBarItems()
        getData()
        addPopupView()
        //Hero.shared.defaultAnimation = .selectBy(presenting: .fade, dismissing: .fade)
        self.navigationController?.heroNavigationAnimationType = .fade
        //setupPanGesture()
        //addSwipeLeftAction()
        self.isHeroEnabled = true
    }
    override func viewWillAppear(_ animated: Bool) {
        //self.navigationController?.setNavigationBarHidden(true, animated: true)
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.tabBarController?.setTabBarVisible(visible: true, animated: false)
//        UIApplication.shared.statusBarStyle = .lightContent
//        UIApplication.shared.statusBarView?.backgroundColor = UIColor(white: 0, alpha: 0.6)
        //UIApplication.shared.statusBarView.opa
        //UIApplication.shared.statusBarView?.alpha = 0.5
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
        //bottomPopupView.isHidden = true
        
        //view.bringSubview(toFront: bottomPopupView)
        //self.view.layoutSubviews()

    }
    func getData(){
        ServerAPIManager.sharedAPI.getCourseDetails(course_id: course_id, setCourse, showError: showErrorAlert)
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
        registerCell(nibName: "CourseActionTableViewCell")
        registerCell(nibName: "CommentsTableViewCell")
        registerCell(nibName: "ServicesTableViewCell")
        registerCell(nibName: "BranchesTableViewCell")
        registerCell(nibName: "ContactsTableViewCell")
        registerCell(nibName: "DescriptionTableViewCell")
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 44
        tableView.reloadData()
        addHeaderView()
        //tableView.configRefreshHeader(with: getRefreshHeader(), action: { [weak self] in
//            self?.getData()
//        })
        
    }
    func addHeaderView(){
        headerView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = headerView
        headerView.centerXAnchor.constraint(equalTo: self.tableView.centerXAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.tableView.widthAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.tableView.topAnchor).isActive = true
        headerView.heightAnchor.constraint(equalToConstant: Constants.SCREEN_HEIGHT * 1 / 2).isActive = true
        tableView.layoutIfNeeded()
        headerView.menuBarView.cellDelegate = self
        tableView.tableHeaderView = tableView.tableHeaderView
        let mainImageUrl = URL(string: courseBackImage)
        headerView.mainImageView.kf.setImage(with: mainImageUrl)
        headerView.mainImageView.heroID = "\(courseName)_image"
        headerView.mainImageView.heroModifiers = [.zPosition(2)]
        headerView.logoImageView.heroID = "\(courseName)_logo"
        headerView.logoImageView.heroModifiers = [.beginWith([.zPosition(5), .useGlobalCoordinateSpace])]
        headerView.titleLabel.heroID = "\(courseName)_name"
        headerView.titleLabel.heroModifiers = [.zPosition(10)]
//        nameLabel.text = name
//        nameLabel.heroID = "\(name)_name"
//        nameLabel.heroModifiers = [.zPosition(4)]
//        imageView.image = city.image
//        imageView.heroID = "\(name)_image"
//        imageView.heroModifiers = [.zPosition(2)]
//        descriptionLabel.heroID = "\(name)_description"
//        descriptionLabel.heroModifiers = [.zPosition(4)]
//        descriptionLabel.text = city.description
        
        let logoImageUrl = URL(string: courseLogo)
        headerView.logoImageView.kf.setImage(with: logoImageUrl)
        headerView.titleLabel.text = courseName
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
        case "CourseActionTableViewCell":
            return course.actions.count
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
            cell.fillCell(description: courseDescription)
            return cell
            //tableView.separatorStyle = .none
        case "CourseActionTableViewCell":
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as!
            CourseActionTableViewCell
            cell.fillCell(action: course.actions[indexPath.row])
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
            case "CourseActionTableViewCell":
                let promotionVC = UIStoryboard.init(name: "News", bundle: nil).instantiateViewController(withIdentifier: "PromotionsDetailViewController") as! PromotionsDetailViewController
                let courseHeader = CourseHeader(id: course_id, title: courseName, logo_image_url: courseLogo, main_image_url: courseBackImage, description: courseDescription)
                promotionVC.courseHeader = courseHeader
                promotionVC.simpleAction = course.actions[indexPath.row]
                promotionVC.isFromCourse = true
                self.navigationController?.show(promotionVC, sender: self)
            case "BranchesTableViewCell":
                print("branches")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "MapViewController") as! MapViewController
                vc.branches = self.course.branches
                vc.branch_id = indexPath.row
                vc.branch_title = self.course.title
                self.navigationController?.show(vc, sender: self)
            case "ContactsTableViewCell":
                DispatchQueue.main.async(execute: {
                    let contactType: ContactTypes = ContactTypes(rawValue: self.course.contacts[indexPath.row].type)!
                    let contactValue = self.course.contacts[indexPath.row].contact
                    switch contactType {
                    case .EMAIL:
                        contactValue.mailTo(controller: self)
                    case .PHONE:
                       contactValue.callToPhone()
                    case .FACEBOOK, .WEBSITE:
                        contactValue.openLink(controller: self)
                    case .WHATSAPP:
                        self.copyNumber()
                    }
                })
            default:
                print("services")
            }
        }
    }
    private func copyNumber(){
        if isBottomPopupCompleted {
            //self.bottomPopupView.isHidden = false
            let offset = self.view.frame.height - (self.tabBarController?.tabBar.frame.origin.y)!
            print(offset)

            UIView.animate(withDuration: 0.5, animations: {
                self.bottomPopupView.frame.origin.y -= (50 + offset)
            }, completion: { (completed) in
                DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
                    UIView.animate(withDuration: 0.5, animations: {
                        //self.bottomPopupView.alpha = 0
                        self.bottomPopupView.frame.origin.y += (50 + offset)
                        //self.view.layoutIfNeeded()
                    }, completion: { (completed) in
                        self.isBottomPopupCompleted = true
                        //self.bottomPopupView.isHidden = true

                    })
                })
            })
            isBottomPopupCompleted = false
        }
    }
    
    
    func iconPressed(_ index: Int) {
        switch index {
        case 0:
            cellId = "DescriptionTableViewCell"
        case 1:
            cellId = "CourseActionTableViewCell"
        case 2:
            cellId = "BranchesTableViewCell"
        case 3:
            cellId = "ContactsTableViewCell"
        default:
            cellId = "ServicesTableViewCell"
        }
        tableView.reloadSections(IndexSet.init(integer: 0), with: .fade)
    }
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0){
            //self.segmentView.heightAnchor.constraint(equalToConstant: 0).isActive = true
            //self.segmentView.animateConstraintWithDuration()
            self.tabBarController?.setTabBarVisible(visible:false, animated: true)
        }else{
            //self.segmentView.heightAnchor.constraint(equalToConstant: 60).isActive = true
            //self.segmentView.animateConstraintWithDuration()
            self.tabBarController?.setTabBarVisible(visible: true, animated: true)
        }
    }
}

