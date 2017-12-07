//
//  Constants.swift
//  Kaindy-Kant
//
//  Created by Khasanza on 10/9/17.
//  Copyright © 2017 NeoBis. All rights reserved.
//

import Foundation

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
        }
        struct EndPoints {
            static let Token_auth = "api/token-auth"
            static let Categories = "categories"
            static let SubCategories = "category"
            static let CoursesBySubcategory = "subcategory"
            static let CourseDetails = "course"


            

        }
    }

}

