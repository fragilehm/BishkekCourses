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
    func openCourse(id: Int, name: String, logoUrl: String, backUrl: String){
        let courseVC = UIStoryboard.init(name: "Course", bundle: nil).instantiateViewController(withIdentifier: "DetailedCourseViewController") as! DetailedCourseViewController
        courseVC.courseName = name
        courseVC.courseBackImage = backUrl
        courseVC.courseLogo = logoUrl
        courseVC.course_id = id
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
                return "iPhone 4"
            case 1334:
                return "iPhone 4.7"
            case 2208:
                return "iPhone 5.5"
            case 2436:
                return "iPhone 5.8"
            default:
                return "unknown"
            }
        }
        else if UIDevice().userInterfaceIdiom == .pad {
            switch UIScreen.main.nativeBounds.height {
            case 2732:
                return "ipad 12.9"
            case 2224:
                return "ipad 10.5"
            case 2048:
                return "ipad 9.7"
            default:
                return "unknown"
            }
        }
        return "unknown"
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

