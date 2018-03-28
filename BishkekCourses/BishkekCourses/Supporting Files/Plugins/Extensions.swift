//
//  Extensions.swift
//  elDiscount
//
//  Created by ZYFAR on 06.09.17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import UIKit
import HGPlaceholders
import PullToRefreshKit
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(netHex:Int) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff)
    }
}

extension UIViewController {
    func openCourse(id: Int, name: String, logoUrl: String, backUrl: String, description: String){
        let courseVC = UIStoryboard.init(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "DetailedCourseViewController") as! DetailedCourseViewController
        courseVC.courseName = name
        courseVC.courseBackImage = backUrl
        courseVC.courseLogo = logoUrl
        courseVC.course_id = id
        courseVC.courseDescription = description
        self.navigationController?.show(courseVC, sender: self)
    }
    func showErrorAlert(message: String) {
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func setNavigationBarItems(){
        let backButton = UIButton.init(type: .system)
        backButton.setImage(#imageLiteral(resourceName: "back").withRenderingMode(.alwaysOriginal), for: .normal)
        backButton.frame = CGRect(x: 0, y: 0, width: 30, height: 30)
        backButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        backButton.imageView?.contentMode = .scaleAspectFit
        backButton.addTarget(self, action: #selector(backPressed(_:)), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
    }
    func setSwipeLeftAction(){
        let swipe: UIGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeLeft))
        self.view.addGestureRecognizer(swipe)
    }
    @objc func swipeLeft(){
        self.navigationController?.popViewController(animated: true)
    }
    @objc func backPressed(_ button: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    func getDeviceName() -> String {
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                return Constants.Devices.IPHONE_4
            case 1334:
                return Constants.Devices.IPHONE_4_7
            case 2208:
                return Constants.Devices.IPHONE_5_5
            case 2436:
                return Constants.Devices.IPHONE_5_8
            default:
                return Constants.Devices.UNKNOWN
            }
        }
        else if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.nativeBounds.height {
            case 2732:
                return Constants.Devices.IPAD_12_9
            case 2224:
                return Constants.Devices.IPAD_10_5
            case 2048:
                return Constants.Devices.IPAD_9_7
            default:
                return Constants.Devices.UNKNOWN
            }
        }
        return Constants.Devices.UNKNOWN
    }
    func getRefreshHeader() -> DefaultRefreshHeader {
        let header = DefaultRefreshHeader.header()
        header.setText(Constants.Hint.Refresh.pull_to_refresh, mode: .pullToRefresh)
        header.setText(Constants.Hint.Refresh.relase_to_refresh, mode: .releaseToRefresh)
        header.setText(Constants.Hint.Refresh.success, mode: .refreshSuccess)
        header.setText(Constants.Hint.Refresh.refreshing, mode: .refreshing)
        header.setText(Constants.Hint.Refresh.failed, mode: .refreshFailure)
        header.imageRenderingWithTintColor = true
        header.durationWhenHide = 0.4
        return header
    }
    
}
class CustomTextField: UITextField {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, 
                                     UIEdgeInsetsMake(12, 12, 12, 12))
    }
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds, 
                                     UIEdgeInsetsMake(12, 12, 12, 12))
    }
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return UIEdgeInsetsInsetRect(bounds,
                                     UIEdgeInsetsMake(12, 12, 12, 12))
    }
    
}

extension PlaceholdersProvider {
    static var summer: PlaceholdersProvider {
        var commonStyle = PlaceholderStyle()
        commonStyle.backgroundColor = UIColor.white
        commonStyle.actionBackgroundColor = .black
        commonStyle.actionTitleColor = .white
        commonStyle.titleColor = .black
        commonStyle.isAnimated = false
//        commonStyle.
//        commonStyle.titleColor = UIFont(name: "AvenirNextCondensed-HeavyItalic", size: 19)!
//        commonStyle.subtitleColor = UIFont(name: "AvenirNextCondensed-Italic", size: 19)!
//        commonStyle.actionTitleColor = UIFont(name: "AvenirNextCondensed-Heavy", size: 19)!
//
        var loadingStyle = commonStyle
        loadingStyle.actionBackgroundColor = .clear
        loadingStyle.actionTitleColor = .gray
        
        var loadingData: PlaceholderData = .loading
        loadingData.image = #imageLiteral(resourceName: "hg-loading")
        let loading = Placeholder(data: loadingData, style: loadingStyle, key: .loadingKey)
        
        var errorData: PlaceholderData = .error
        errorData.image = #imageLiteral(resourceName: "hg-error")
        let error = Placeholder(data: errorData, style: commonStyle, key: .errorKey)
        
        var noResultsData: PlaceholderData = .noResults
        noResultsData.image = #imageLiteral(resourceName: "hg-no_results")
        let noResults = Placeholder(data: noResultsData, style: commonStyle, key: .noResultsKey)
        
        var noConnectionData: PlaceholderData = .noConnection
        noConnectionData.image = #imageLiteral(resourceName: "hg-no_connection")
        let noConnection = Placeholder(data: noConnectionData, style: commonStyle, key: .noConnectionKey)
        
        let placeholdersProvider = PlaceholdersProvider(loading: loading, error: error, noResults: noResults, noConnection: noConnection)
        
        let xibPlaceholder = Placeholder(cellIdentifier: "CustomPlaceholderCell", key: PlaceholderKey.custom(key: "XIB"))
        
        placeholdersProvider.add(placeholders: PlaceholdersProvider.starWarsPlaceholder, xibPlaceholder)
        
        return placeholdersProvider
    }
    
    private static var starWarsPlaceholder: Placeholder {
        var starwarsStyle = PlaceholderStyle()
        starwarsStyle.backgroundColor = .white
        starwarsStyle.actionBackgroundColor = .clear
        starwarsStyle.actionTitleColor = .black
        starwarsStyle.titleColor = .black
        starwarsStyle.isAnimated = false
        
        var starwarsData = PlaceholderData()
        starwarsData.title = NSLocalizedString("\"Coming Soon!!!\"", comment: "")
        starwarsData.subtitle = NSLocalizedString("", comment: "")
        starwarsData.image = #imageLiteral(resourceName: "mind")
        starwarsData.action = NSLocalizedString("OK!", comment: "")
        
        let placeholder = Placeholder(data: starwarsData, style: starwarsStyle, key: PlaceholderKey.custom(key: "starWars"))
        
        return placeholder
    }
}
extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}
extension UIColor {
    func as1ptImage() -> UIImage {
        UIGraphicsBeginImageContext(CGSize(width: 0.3, height: 0.3))
        setFill()
        UIGraphicsGetCurrentContext()?.fill(CGRect(x: 0, y: 0, width: 0.3, height: 0.3))
        let image = UIGraphicsGetImageFromCurrentImageContext() ?? UIImage()
        UIGraphicsEndImageContext()
        return image
    }
}
extension UITabBarController {
    func setTabBarVisible(visible:Bool, animated:Bool) {
        if (tabBarIsVisible() == visible) { return }
        let frame = self.tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)

        UIView.animate(withDuration: animated ? 0.3 : 0.0, animations: {
            self.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        })

    }
    func tabBarIsVisible() -> Bool {
        var offset: CGFloat = 0
        if UIDevice().userInterfaceIdiom == .phone {
            offset = UIScreen.main.nativeBounds.height == 2436 ? (UIApplication.shared.statusBarView?.frame.height)! > CGFloat(40) ? 20 : 0 : (UIApplication.shared.statusBarView?.frame.height)! > CGFloat(20) ? 20 : 0
        }
        return self.tabBar.frame.origin.y + offset < Constants.SCREEN_HEIGHT
    }
}
extension UINavigationController {
    func setNavigationBarVisible(visible:Bool, animated:Bool) {
        print(visible, "-", self.navigationBar.isHidden)
        if self.navigationBar.isHidden != visible { return }
        let frame = self.navigationBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        navigationBar.isHidden = false
        UIView.animate(withDuration: animated ? 0.3 : 0.0, animations: {
            self.navigationBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }) { (finished) in
            if finished {
                self.navigationBar.isHidden = !visible
            }
        }
    }
}
extension UIView {
    func animateConstraintWithDuration(_ duration: TimeInterval = 0.3, delay: TimeInterval = 0.5, completion: @escaping (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animate(withDuration: duration, delay: delay, options: UIViewAnimationOptions.curveEaseIn, animations: {
            self.layoutIfNeeded()
        }, completion: completion)
    }
}
extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    func getExperience() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GTM+6:00")
        let date = dateFormatter.date(from: self)
        let currentDate = Date()
        let years = Calendar.current.dateComponents([.year], from: date!, to: currentDate).year
        return years! <= 1 ? "1 год" : "\(years!) лет"
    }
    func callToPhone(){
        let temp = self.returnNumber(number: self)
        if let url = NSURL(string: "telprompt:\(temp)"){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
            } else {
                
            }
        }
    }
    func returnNumber(number: String) -> String {
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
    func returnNumber() -> String {
        var ans = [Character]()
        for char in self {
            if ((String(char).rangeOfCharacter(from: CharacterSet.alphanumerics.inverted)) == nil) {
                ans.append(char)
            }
            else if (String(char) == "+"){
                ans.append(char)
            }
        }
        return String(ans)
    }
    func mailTo(controller: UIViewController){
        let alertController = UIAlertController(title: "Написать на почту?", message: "\(self)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let url = URL(string: "mailto:\(self)") {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url as URL, options: [:], completionHandler: nil)
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        controller.present(alertController, animated: true, completion: nil)
        
    }
    func openLink(controller: UIViewController){
        print("open")
        let alertController = UIAlertController(title: "Открыть в браузере?", message: "\(self)", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            if let url = URL(string: self) {
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(url, options: [:])
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        let cancelAction = UIAlertAction(title: "Отменить", style: .cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
    
        controller.present(alertController, animated: true, completion: nil)
        
    }
    func getConvertedDate() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd" //Your date format
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+6:00") //Current time zone
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "d MMMM"
        dateFormatter.locale = Locale(identifier: "ru_RU")
        return dateFormatter.string(from: date!)
    }
}
extension UITableView {
    func configureRefreshHeader(_ completion: @escaping ()-> Void) {
        let header = DefaultRefreshHeader.header()
        header.setText(Constants.Hint.Refresh.pull_to_refresh, mode: .pullToRefresh)
        header.setText(Constants.Hint.Refresh.relase_to_refresh, mode: .releaseToRefresh)
        header.setText(Constants.Hint.Refresh.success, mode: .refreshSuccess)
        header.setText(Constants.Hint.Refresh.refreshing, mode: .refreshing)
        header.setText(Constants.Hint.Refresh.failed, mode: .refreshFailure)
        header.imageRenderingWithTintColor = true
        header.durationWhenHide = 0.4
        self.configRefreshHeader(with: header) {
            completion()
        }
    }
    func configureRefreshFooter(_ completion: @escaping ()-> Void) {
        let footer = DefaultRefreshFooter.footer()
        footer.setText(Constants.Hint.Refresh.pull_to_refresh, mode: .pullToRefresh)
        //footer.setText(Constants.Hint.Refresh.relase_to_refresh, mode: .refreshing)
        footer.setText(Constants.Hint.Refresh.refreshing, mode: .refreshing)
        footer.refreshMode = .scroll
        self.configRefreshFooter(with: footer) {
            completion()
        }
    }
}
