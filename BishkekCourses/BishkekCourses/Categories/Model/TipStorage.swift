//
//  TipStorage.swift
//  BishkekCourses
//
//  Created by Khasanza on 4/12/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
class TipStorage {
    
    let tipShowKey = "com.categories.tips"
    func setTipShowed() -> Void {
        let userDefaults = UserDefaults.standard
        userDefaults.set(true, forKey: tipShowKey)
    }
    func isTipShowed() -> Bool {
        let userDefaults = UserDefaults.standard
        let isTipShowed = userDefaults.object(forKey: tipShowKey)
        return isTipShowed as? Bool ?? false
    }
    
    let tipTitle = Constants.Categories.CoursesBySubcategory.TipText.TITLE
    let tipDescription = Constants.Categories.CoursesBySubcategory.TipText.DESCRIPTION

//    func getTipText() -> [String: String] {
//        let title = Constants.Categories.CoursesBySubcategory.TipText.TITLE
//        let description = Constants.Categories.CoursesBySubcategory.TipText.DESCRIPTION
//        return ["title": title, "description": description]
//    }
}
