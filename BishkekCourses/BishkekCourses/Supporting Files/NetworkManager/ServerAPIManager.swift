//
//  ServerAPIManager.swift
//  BishkekCourses
//
//  Created by Khasanza on 1/29/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
import Moya_ModelMapper
import SwiftyJSON
class ServerAPIManager: NetworkAdapter  {

    class var sharedAPI: ServerAPIManager {
        struct Static {
            static let instance = ServerAPIManager()
        }
        return Static.instance
    }
    //MARK: Categories
    func getCategories(_ completion: @escaping ([Category])-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.categories, success: { (response) in
            do {
                let categories: [Category] = try response.map(to: [Category].self)
                completion(categories)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    func getSubcategories(category_id: Int,_ completion: @escaping ([Subcategory])-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.subcategories(categoryId: category_id), success: { (response) in
            do {
                let subcategories: [Subcategory] = try response.map(to: [Subcategory].self)
                completion(subcategories)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    //MARK: Courses

    func getCoursesBySubcategory(subcategory_id: Int,_ completion: @escaping ([SimpleCourse])-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.coursesBySubcategory(subcategoryId: subcategory_id), success: { (response) in
            do {
                let simpleCourses: [SimpleCourse] = try response.map(to: [SimpleCourse].self)
                completion(simpleCourses)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    func getCourseDetails(course_id: Int,_ completion: @escaping (DetailedCourse)-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.courseDetails(courseId: course_id), success: { (response) in
            do {
                let course: DetailedCourse = try response.map(to: DetailedCourse.self)
                completion(course)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    func getRecentCourses(_ completion: @escaping ([SimpleCourse])-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.courseRecent, success: { (response) in
            do {
                let simpleCourses: [SimpleCourse] = try response.map(to: [SimpleCourse].self)
                completion(simpleCourses)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    //MARK: Actions

    func getActions(_ completion: @escaping ([Promotion])-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.actions, success: { (response) in
            do {
                let promotions: [Promotion] = try response.map(to: [Promotion].self)
                completion(promotions)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    
    func getActionsBySubcategory(subcategory_id: Int,_ completion: @escaping ([Promotion])-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.actionsBySubcategory(subcategoryId: subcategory_id), success: { (response) in
            do {
                let actions: [Promotion] = try response.map(to: [Promotion].self)
                completion(actions)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    //MARK: Tutors
    func getTutors(_ completion: @escaping ([Tutor])-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.tutors, success: { (response) in
            do {
                let tutors: [Tutor] = try response.map(to: [Tutor].self)
                completion(tutors)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    func getTutorsBySubcategory(subcategory_id: Int,_ completion: @escaping ([Tutor])-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.tutorsBySubcategory(subcategoryId: subcategory_id), success: { (response) in
            do {
                let tutors: [Tutor] = try response.map(to: [Tutor].self)
                completion(tutors)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
}

