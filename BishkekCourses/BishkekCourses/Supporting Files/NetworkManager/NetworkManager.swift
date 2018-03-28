//
//  NetworkManager.swift
//  BishkekCourses
//
//  Created by Khasanza on 1/29/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
import Moya

enum NetworkManager {
    case token_auth
    case categories
    case univesityCategories
    case subcategories(categoryId: Int)
    case coursesBySubcategory(subcategoryId: Int)
    case universitiesByCategory(categoryId: Int)
    case courseDetails(courseId: Int)
    case universityDetails(universityId: Int)
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
        return URL(string: "http://46.101.146.101:8081")!
    }
    
    var path: String {
        switch self {
        case .token_auth:
            return "/api/token-auth"
        case .categories:
            return "/categories"
        case .univesityCategories:
            return "/universities/categories"
        case .subcategories(let categoryId):
            return "/categories/\(categoryId)"
        case .coursesBySubcategory(let subcategoryId):
            return "/subcategories/\(subcategoryId)"
        case .universitiesByCategory(let categoryId):
            return "/universities/categories/\(categoryId)"
        case .courseDetails(let courseId):
            return "/courses/\(courseId)"
        case .universityDetails(let universityId):
            return "/universities/\(universityId)"
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
        switch self {
        case .courseRecent:
            return .requestPlain
            //return .requestParameters(parameters: [:], encoding: JSONEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        switch self {
        case .token_auth:
            return nil
        default:
            return nil
            //return ["Content-type": "application/json"]
        }
    }
    
    
}
