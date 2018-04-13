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
    static let PLACEHOLDER_IMAGE = UIImage(named: "placeholder-image")
    static var shared: Constants {
        struct Static {
            static let instance = Constants()
        }
        return Static.instance
    }
    struct Network {
        
        struct ErrorMessage {
            static let NO_INTERNET_CONNECTION = "Отсутствует интернет соединение"
            static let UNABLE_LOAD_DATA = "Неудалось загрузить данные, возможно сервер временно недоступен"
            static let NO_HTTP_STATUS_CODE = "Unable to get response HTTP status code"
            static let UNAUTHORIZED = "Ошибка авторизации"
            static let NOT_FOUND_ERROR = "Проверьте интернет соединение"
            static let CANT_PARSE_DATA = "Неудалось загрузить данные, возможно сервер временно недоступен"


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
    
    struct Main {
        struct ControllerID {
            static let MAIN_ROOT_VIEWCONTROLLER = "MainRootViewController"
            static let MAIN_VIEWCONTROLLER = "MainViewController"
        }
        struct CellID {
            static let MAIN_TABLEVIEW_CELL = "MainTableViewCell"
        }
        
    }
    struct Categories {
        struct ControllerID {
            static let CATEGORIES_VIEWCONTROLLER = "CategoriesViewController"
            static let SUB_CATEGORIES_VIEWCONTROLLER = "SubCategoriesViewController"
            static let COURSES_BY_SUBCATEGORY_VIEWCONTROLLER = "CoursesBySubcategoryViewController"
        }
        struct CellID {
            static let CATEGORIES_COLLECTIONVIEW_CELL = "CategoriesCollectionViewCell"
            static let SUBCATEGORIES_COLLECTIONVIEW_CELL = "SubCategoriesCollectionViewCell"
            static let COURSES_BY_SUBCATEGORY_TABLEVIEW_CELL = "CoursesBySubcategoryTableViewCell"
        }
        struct CoursesBySubcategory {
            struct ActionSheetTitle {
                static let COURSES = "Курсы"
                static let ACTIONS = "Акции"
                static let TUTORS = "Репетиторы"
            }
            struct ActionSheetText {
                static let TITLE = "Выберите тип"
                static let CANCEL = "Отменить"
            }
            struct TipText {
                static let TITLE = "Подсказка!"
                static let DESCRIPTION = "Нажав на данную кнопку, вы можете выбрать тип показываемых данных в определенной категории"
            }
        }
        
    }
    struct DetailedCourse {
        static let INSTAGRAM_LINK = "https://www.instagram.com/"
        struct ControllerID {
            static let DETAILED_COURSE_VIEWCONTROLLER = "DetailedCourseViewController"
            static let MAP_VIEWCONTROLLER = "MapViewController"
        }
        struct CellID {
            static let COURSE_ACTION_TABLEVIEW_CELL = "CourseActionTableViewCell"
            static let COMMENTS_TABLEVIEW_CELL = "CommentsTableViewCell"
            static let BRANCHES_TABLEVIEW_CELL = "BranchesTableViewCell"
            static let SERVICES_TABLEVIEW_CELL = "ServicesTableViewCell"
            static let CONTATCS_TABLEVIEW_CELL = "ContactsTableViewCell"
            static let DESCRIPTION_TABLEVIEW_CELL = "DescriptionTableViewCell"
            static let HEADER_TABLEVIEW_CELL = "HeaderTableViewCell"
            static let MENU_COLLECTIONVIEW_CELL = "MenuCollectionViewCell"
            static let DEPARTMENT_TABLEVIEW_CELL = "DepartmentTableViewCell"
            static let GRANT_TABLEVIEW_CELL = "GrantTableViewCell"


        }
        static var CONTACT_TYPE = ""
        static let MENU_IMAGES = ["description", "promotion", "locations", "contacts", "services"]

    }
    struct Login {
        struct ControllerID {
            static let LOGIN_MAIN_VIEWCONTROLLER = "LoginMainViewController"
            static let SIGNUP_VIEWCONTROLLER = "SignUpViewController"
            static let LOGIN_VIEWCONTROLLER = "LoginViewController"

        }
        struct CellID {
        }
    }
    struct Settings {
        static let LOGOUT_TEXT = "Выйти"
        struct ControllerID {
            static let SETTINGS_VIEWCONTROLLER = "SettingsViewController"
        }
        struct CellID {
            static let SETTINGS_TABLEVIEW_CELL = "SettingsTableViewCell"
            static let PROFILE_TABLEVIEW_CELL = "ProfileTableViewCell"
            static let LOGOUT_TABLEVIEW_CELL = "LogoutTableViewCell"
        }
        
    }
    struct Tutor {
        struct ControllerID {
            static let TUTOR_VIEWCONTROLLER = "TutorViewController"
            static let TUTOR_DETAIL_VIEWCONTROLLER = "TutorDetailViewController"
        }
        struct CellID {
            static let TUTOR_TABLEVIEW_CELL = "TutorTableViewCell"
        }
    }
    struct Promotions {
        struct ControllerID {
            static let PROMOTIONS_VIEWCONTROLLER = "PromotionsViewController"
            static let PROMOTIONS_DETAIL_VIEWCONTROLLER = "PromotionsDetailViewController"
        }
        struct CellID {
            static let PROMOTION_TABLEVIEW_CELL = "PromotionTableViewCell"

        }
    }
    struct News {
        struct ControllerID {
            static let NEWS_VIEWCONTROLLER = "NewsViewController"
            static let NEWS_DETAIL_VIEWCONTROLLER = "NewsDetailViewController"
        }
        struct CellID {
            static let NEWS_TABLEVIEW_CELL = "NewssTableViewCell"
            
        }
    }
    struct Grants {
        struct ControllerID {
            static let GRANT_DETAIL_VIEWCONTROLLER = "GrantDetailViewController"
        }
        struct CellID {
            static let GRANT_TABLEVIEW_CELL = "GrantTableViewCell"
            
        }
    }
    struct Storyboards {
        static let MAIN = "Main"
        static let LOGIN = "Login"
        static let CATEGORIES = "Categories"
        static let FAVORITE = "Favorite"
        static let COURSE = "Course"
        static let TUTOR = "Tutor"
        static let SETTINGS = "Settings"
        static let STARTING_PAGE = "StartingPage"
        static let SEARCH = "Search"
        static let NEWS = "News"
        static let PROMOTION = "Promotion"
        static let GRANTS = "Grant"
    }
    struct Titles {
        static let MAIN = "Главная"
        static let LOGIN = "Логин"
        static let CATEGORIES = "Категории"
        static let SUBCATEGORIES = "Подкатегории"
        static let FAVORITE = "Избранные"
        static let TUTOR = "Репетиторы"
        static let SETTINGS = "Настройки"
        static let SEARCH = "Поиск"
        static let NEWS = "Новости"
        static let UNIVERSITIES = "Университеты"

    }
//    struct Devices {
//        static let IPHONE_4 = "iPhone 4"
//        static let IPHONE_4_7 = "iPhone 4.7"
//        static let IPHONE_5_5 = "iPhone 5.5"
//        static let IPHONE_5_8 = "iPhone 5.8"
//        static let IPAD_12_9 = "ipad 12.9"
//        static let IPAD_10_5 = "ipad 10.5"
//        static let IPAD_9_7 = "ipad 9.7"
//        static let UNKNOWN = "unknown"
//    }
}

