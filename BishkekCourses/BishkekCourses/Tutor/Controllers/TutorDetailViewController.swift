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
    let header = TutorHeaderView()
    var tutor: Tutor?
    private var detailedTutor = DetailedTutor()
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
        view.backgroundColor = UIColor(netHex: Colors.DARK_PURPLE)
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.view.backgroundColor = .white
        setNavBarItems()
        addHeaderView()
        configureTableView()
        getData()
        addPopupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.barTintColor = UIColor.init(netHex: Colors.TUTOR_BACKGROUND)
        self.tabBarController?.setTabBarVisible(visible: true, animated: false)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.barTintColor = UIColor.white
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.shadowImage = nil
        self.tabBarController?.setTabBarVisible(visible: true, animated: true)
    }
    func addPopupView() {
        bottomPopupView.addSubview(popupLabel)
        popupLabel.centerXAnchor.constraint(equalTo: bottomPopupView.centerXAnchor).isActive = true
        popupLabel.centerYAnchor.constraint(equalTo: bottomPopupView.centerYAnchor).isActive = true
        self.view.addSubview(bottomPopupView)
        bottomPopupView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        bottomPopupView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        bottomPopupView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        bottomPopupView.topAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
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
    func getRightItem(image: UIImage) -> UIButton {
        let favoriteButton = UIButton.init(type: .system)
        favoriteButton.setImage(image.withRenderingMode(.alwaysOriginal), for: .normal)
        favoriteButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        favoriteButton.imageView?.contentMode = .scaleAspectFit
        return favoriteButton
    }
    func configureTableView(){
        tableView.tableHeaderView = header
        //tableView.sectionFooterHeight = 0
        tableView.tableFooterView = UIView()
        tableView.register(UINib.init(nibName: Constants.DetailedCourse.CellID.CONTATCS_TABLEVIEW_CELL, bundle: nil) , forCellReuseIdentifier: Constants.DetailedCourse.CellID.CONTATCS_TABLEVIEW_CELL)
        tableView.register(UINib.init(nibName: Constants.DetailedCourse.CellID.DESCRIPTION_TABLEVIEW_CELL, bundle: nil) , forCellReuseIdentifier: Constants.DetailedCourse.CellID.DESCRIPTION_TABLEVIEW_CELL)
        tableView.register(UINib.init(nibName: Constants.DetailedCourse.CellID.BRANCHES_TABLEVIEW_CELL, bundle: nil) , forCellReuseIdentifier: Constants.DetailedCourse.CellID.BRANCHES_TABLEVIEW_CELL)
    }
    func addHeaderView() {
        let url = URL(string: (tutor?.tutor_image)!)
        header.tutorImageView.kf.setImage(with: url, placeholder: Constants.PLACEHOLDER_IMAGE, options: nil, progressBlock: nil, completionHandler: nil)
        header.nameLabel.text = tutor?.name
        let experienceBoldText = NSMutableAttributedString(string: "Стаж: ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)])
        let experienceText = NSMutableAttributedString(string: (tutor?.start_date.getExperience())!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)])
        experienceBoldText.append(experienceText)
        header.experienceLabel.attributedText = experienceBoldText
        let priceBoldText = NSMutableAttributedString(string: "Стоимость: ", attributes: [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.boldSystemFont(ofSize: 17)])
        let priceText = NSMutableAttributedString(string: (tutor?.price)!, attributes: [NSAttributedStringKey.foregroundColor: UIColor.black, NSAttributedStringKey.font: UIFont.systemFont(ofSize: 17)])
        priceBoldText.append(priceText)
        header.priceLabel.attributedText = priceBoldText
        header.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: Constants.SCREEN_HEIGHT * 1 / 2)

    }
    func getData(){
        ServerAPIManager.sharedAPI.getDetailedTutor(tutor_id: (tutor?.id)!, setTutor, showError: showErrorAlert)
    }
    func setTutor(tutor: DetailedTutor) {
        self.detailedTutor = tutor
        tableView.reloadData()
    }
}
extension TutorDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 1
        case 2:
            return self.detailedTutor.contacts.count
        default:
            return self.detailedTutor.branches.count
        }
       
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.DetailedCourse.CellID.DESCRIPTION_TABLEVIEW_CELL, for: indexPath) as! DescriptionTableViewCell
            cell.descriptionLabel.text = tutor?.description
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.DetailedCourse.CellID.DESCRIPTION_TABLEVIEW_CELL, for: indexPath) as! DescriptionTableViewCell
            cell.descriptionLabel.text = tutor?.timetable
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.DetailedCourse.CellID.CONTATCS_TABLEVIEW_CELL, for: indexPath) as! ContactsTableViewCell
            cell.contactLabel.text = detailedTutor.contacts[indexPath.row].contact
            cell.contactImageView.image = cell.getContactIcon(type: detailedTutor.contacts[indexPath.row].type)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.DetailedCourse.CellID.BRANCHES_TABLEVIEW_CELL, for: indexPath) as! BranchesTableViewCell
            cell.addressLabel.text = detailedTutor.branches[indexPath.row].address
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case 2:
            DispatchQueue.main.async(execute: {
                let contactType: ContactTypes = ContactTypes(rawValue: self.detailedTutor.contacts[indexPath.row].type)!
                let contactValue = self.detailedTutor.contacts[indexPath.row].contact
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
        case 3:
            let storyboard = UIStoryboard.init(name: Constants.Storyboards.COURSE, bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: Constants.DetailedCourse.ControllerID.MAP_VIEWCONTROLLER) as! MapViewController
            vc.branches = detailedTutor.branches
            vc.branch_id = indexPath.row
            vc.branch_title = (self.tutor?.name)!
            self.navigationController?.show(vc, sender: self)
        default:
            print("description or timetable")
        }
        
    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let space: CGFloat = section == 0 ? 0 : 20
        let view = UIView()
        view.backgroundColor = UIColor.clear
        view.frame = CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 30 + space)
        let label = UILabel(frame: CGRect(x: 16, y: 25 - space, width: self.tableView.bounds.width - 10, height: 20))
        view.addSubview(label)
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = UIColor.darkGray
        label.text = Constants.TUTOR_HEADERS[section]
        return view
    }
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 50 : 30
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 3 ? 50 : 20
    }
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let bound = (740 + 17 * Constants.SCREEN_HEIGHT) / 40

        if scrollView.contentOffset.y > bound {
            self.navigationItem.title = tutor?.name
        }
        else {
            self.navigationItem.title = ""
        }
    }
    private func copyNumber(number: String){
        if isBottomPopupCompleted {
            UIPasteboard.general.string = number.returnNumber()
            let offset = self.view.frame.height - (self.tabBarController?.tabBar.frame.origin.y)!
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
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if(velocity.y>0){
            self.tabBarController?.setTabBarVisible(visible:false, animated: true)
        }else{
            self.tabBarController?.setTabBarVisible(visible: true, animated: true)
        }
    }
    
    
}
