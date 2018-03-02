//
//  Constants.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation
import UIKit
struct Constants {
    
    static var lang: String?
    
    static var shared: Constants {
        struct Static {
            static let instance = Constants()
        }
        return Static.instance
    }
    struct Network {
        
        struct ErrorMessage {
            static let NO_INTERNET_CONNECTION = "No internet connection"
            static let UNABLE_LOAD_DATA = "Unable load data"
            static let NO_HTTP_STATUS_CODE = "Unable to get response HTTP status code"
            static let UNAUTHORIZED = "Unauthorized error"
            static let NOT_FOUND_ERROR = "Unable to connect to server"
            static let CANT_PARSE_DATA = "Unable to parse data"


        }
        struct EndPoints {
            static let Token_auth = "api/token-auth"
            static let Categories = "categories"
            static let SubCategories = "categories"
            static let CoursesBySubcategory = "subcategories"
            static let CourseDetails = "courses"
            static let CoursesRecent = "courses/recent"

        }
    }
    struct Hint {
        struct Refresh {
            static let pull_to_refresh = "Потяните"
            static let relase_to_refresh = "Отпустите"
            static let success = "Обновление выполнено"
            static let refreshing = "Обновляется"
            static let failed = "Не удалось обновить"            
        }
    }
    static let SCREEN_WIDTH = UIScreen.main.bounds.width
    static let SCREEN_HEIGHT = UIScreen.main.bounds.height
    struct ElementId {
        static let SUBCATEGORY_IMAGE_ID = 1
        static let SUBCATEGORY_NAME_ID = 2

    }
    static let TUTOR_HEADERS = ["ОБО МНЕ", "ГРАФИК РАБОТЫ", "КОНТАКТЫ", "АДРЕС"]
    static let SETTINGS_TITLES = ["Сохраненные", "Добавить свой курс", "Связаться с нами"]
    static let SETTINGS_IMAGES = ["bookmark_settings", "add", "help"]
    
    struct Identifier {
        struct Main {
            struct ControllerID {
                static let MAIN_ROOT_CONTROLLER = "MainRootViewController"
                static let MAIN_CONTROLLER = "MainViewController"
            }
            struct CellID {
                static let MAIN_TABLE_VIEW_CELL = "MainTableViewCell"
            }
            
        }
        struct Categories {
            struct ControllerID {
                static let CATEGORIES_CONTROLLER = "CategoriesViewController"
                static let SUB_CATEGORIES_CONTROLLER = "SubCategoriesViewController"
                static let COURSES_BY_SUBCATEGORY_CONTROLLER = "CoursesBySubCategoryViewController"

            }
            struct CellID {
                static let MAIN_TABLE_VIEW_CELL = "MainTableViewCell"
            }
            
        }
//        struct Main {
//            struct ControllerID {
//                static let MAIN_ROOT_CONTROLLER = "MainRootViewController"
//                static let MAIN_CONTROLLER = "MainViewController"
//            }
//            struct CellID {
//                static let MAIN_TABLE_VIEW_CELL = "MainTableViewCell"
//            }
//
//        }
    }
    
}

