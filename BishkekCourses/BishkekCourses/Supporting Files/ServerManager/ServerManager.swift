//
//  ServerManager.swift
//  OpenSport
//
//  Created by Sanira on 12/3/16.
//  Copyright © 2016 TimelySoft. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class ServerManager: HTTPRequestManager  {
    
    class var shared: ServerManager {
        struct Static {
            static let instance = ServerManager()
        }
        return Static.instance
    }
    func getCategories(_ completion: @escaping (Categories)-> Void, error: @escaping (String)-> Void) {
        self.get(endpoint: Constants.Network.EndPoints.Categories, completion: { (json) in
            completion(Categories(json: json))
        }, error: error)
    }
    func getSubcategories(category_id: Int,_ completion: @escaping (SubCategories)-> Void, error: @escaping (String)-> Void) {
        self.get(endpoint: "\(Constants.Network.EndPoints.SubCategories)/\(category_id)", completion: { (json) in
            completion(SubCategories(json: json))
        }, error: error)
    }
    func getCoursesBySubcategory(subcategory_id: Int,_ completion: @escaping (SimplifiedCourses)-> Void, error: @escaping (String)-> Void) {
        self.get(endpoint: "\(Constants.Network.EndPoints.CoursesBySubcategory)/\(subcategory_id)", completion: { (json) in
            completion(SimplifiedCourses(json: json))
        }, error: error)
    }
    func getCourseDetails(course_id: Int,_ completion: @escaping (Course)-> Void, error: @escaping (String)-> Void) {
        self.get(endpoint: "\(Constants.Network.EndPoints.CourseDetails)/\(course_id)", completion: { (json) in
            completion(Course(json: json))
        }, error: error)
    }
    func getRecentCourses(_ completion: @escaping (SimplifiedCourses)-> Void, error: @escaping (String)-> Void) {
        self.get(endpoint: "\(Constants.Network.EndPoints.CoursesRecent)", completion: { (json) in
            completion(SimplifiedCourses(json: json))
        }, error: error)
    }
    
    
}
