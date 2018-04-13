//
//  MainPageEnum.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/2/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import Foundation
import UIKit

enum MainPageItems: Int {
    case main = 0
    case categories
    case news
    case university
    case settings
    func getImage() -> UIImage {
        switch self {
        case .main:
            return #imageLiteral(resourceName: "main")
        case .categories:
            return #imageLiteral(resourceName: "categories")
        case .news:
            return #imageLiteral(resourceName: "news")
        case .university:
            return #imageLiteral(resourceName: "university")
        case .settings:
            return #imageLiteral(resourceName: "menu")
        }
    }
}
//enum DetailedCourseCellId: Int {
//    case
//}
enum ContactTypes: String {
    case PHONE
    case WEBSITE
    case EMAIL
    case WHATSAPP
    case FACEBOOK
    case INSTAGRAM
}
