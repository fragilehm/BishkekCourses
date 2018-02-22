//
//  NetworkManager.swift
//  BishkekCourses
//
//  Created by Khasanza on 1/29/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
import Moya

//static let Token_auth = "api/token-auth"
//static let Categories = "categories"
//static let SubCategories = "categories"
//static let CoursesBySubcategory = "subcategories"
//static let CourseDetails = "courses"
//static let CoursesRecent = "courses/recent"
private extension String {
    var URLEscapedString: String {
        return self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
}

enum NetworkManager {
    case token_auth
    case categories
    case subcategories(categoryId: Int)
    case coursesBySubcategory(subcategoryId: Int)
    case courseDetails(courseId: Int)
    case courseRecent
    case actions
    case actionsBySubcategory(subcategoryId: Int)
    case actionDetail(actionId: Int)
    case tutors
    case tutorsBySubcategory(subcategoryId: Int)
    case tutorsDetail(tutorId: Int)

}
extension NetworkManager: TargetType {
    var baseURL: URL {
        return URL(string: "http://46.101.146.101:8000")!
    }
    
    var path: String {
        switch self {
        case .token_auth:
            return "/api/token-auth"
        case .categories:
            return "/categories"
        case .subcategories(let categoryId):
            return "/categories/\(categoryId)"
        case .coursesBySubcategory(let subcategoryId):
            return "/subcategories/\(subcategoryId)"
        case .courseDetails(let courseId):
            return "/courses/\(courseId)"
        case .courseRecent:
            return "/courses/recent"
        case .actions:
            return "/actions"
        case .actionsBySubcategory(let subcategoryId):
            return "/actions/sub/\(subcategoryId)"
        case .actionDetail(let actionId):
            return "actions/\(actionId)"
        case .tutors:
            return "/tutors"
        case .tutorsBySubcategory(let subcategoryId):
            return "/tutors/sub/\(subcategoryId)"
        case .tutorsDetail(let tutorId):
            return "/tutors/\(tutorId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .token_auth:
            return .post
        default:
            return .get
        }
    }
    var sampleData: Data {
        return Data()
    }
    
    var task: Task {
        var parameters: [String: Any]?
        switch self {
        case .token_auth:
            parameters = [String: Any]()
        default:
            parameters = nil
        }
        return .requestParameters(parameters: [:], encoding: JSONEncoding.default)
    }
    
    var headers: [String : String]? {
        switch self {
        case .token_auth:
            return nil
        default:
            return nil
        }
    }
    
    
}
