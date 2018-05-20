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
import Moya
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
                let categories = try JSONDecoder().decode([Category].self, from: response.data)
                completion(categories)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    func getUniversityCategories(_ completion: @escaping ([Category])-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.univesityCategories, success: { (response) in
            do {
                let categories = try JSONDecoder().decode([Category].self, from: response.data)
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
                let subcategories = try JSONDecoder().decode([Subcategory].self, from: response.data)
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
                let simpleCourses = try JSONDecoder().decode([SimpleCourse].self, from: response.data)
                completion(simpleCourses)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    func getUniversitiesByCategory(category_id: Int,_ completion: @escaping ([SimpleUniversity])-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.universitiesByCategory(categoryId: category_id), success: { (response) in
            do {
                let simpleUniversity = try JSONDecoder().decode([SimpleUniversity].self, from: response.data)
                completion(simpleUniversity)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    
    func getCourseDetails(course_id: Int,_ completion: @escaping (DetailedCourse)-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.courseDetails(courseId: course_id), success: { (response) in
            do {
                let course = try JSONDecoder().decode(DetailedCourse.self, from: response.data)
                completion(course)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    func getUniversityDetails(university_id: Int,_ completion: @escaping (DetailedCourse)-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.universityDetails(universityId: university_id), success: { (response) in
            do {
                let university = try JSONDecoder().decode(DetailedCourse.self, from: response.data)
                completion(university)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    func getRecentCourses(pageNumber: Int, _ completion: @escaping (PaginatedCourse)-> Void, showError: @escaping (String)-> Void) {
//        let provider = MoyaProvider<NetworkManager>()
//        provider.request(NetworkManager.courseRecent) { (response) in
//            switch response {
//            case .success(let response):
//                print(response.statusCode)
//            case .failure(let error):
//                print(error.errorDescription)
//            }
//        }
        self.request(target: NetworkManager.courseRecent(pageNumber: pageNumber), success: { (response) in
            do {
                let simpleCourses = try JSONDecoder().decode(PaginatedCourse.self, from: response.data)
                completion(simpleCourses)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    func searchCourses(text: String, _ completion: @escaping ([SimpleCourse])-> Void, showError: @escaping (String)-> Void) {
        //        let provider = MoyaProvider<NetworkManager>()
        //        provider.request(NetworkManager.courseRecent) { (response) in
        //            switch response {
        //            case .success(let response):
        //                print(response.statusCode)
        //            case .failure(let error):
        //                print(error.errorDescription)
        //            }
        //        }
        self.request(target: NetworkManager.searchCourses(text: text), success: { (response) in
            do {
                let simpleCourses = try JSONDecoder().decode([SimpleCourse].self, from: response.data)
                completion(simpleCourses)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    //MARK: Actions

    func getActions(_ completion: @escaping (PaginatedPromotion)-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.actions, success: { (response) in
            do {
                let promotions = try JSONDecoder().decode(PaginatedPromotion.self, from: response.data)
                completion(promotions)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    func getNews(pageNumber: Int, _ completion: @escaping (PaginatedNews)-> Void, showError: @escaping (String)-> Void) {
        print("getNews")
        self.request(target: NetworkManager.news(pageNumber: pageNumber), success: { (response) in
            do {
                print(response.data)

                let news = try JSONDecoder().decode(PaginatedNews.self, from: response.data)
                completion(news)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    
    func getActionsBySubcategory(subcategory_id: Int,_ completion: @escaping ([Promotion])-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.actionsBySubcategory(subcategoryId: subcategory_id), success: { (response) in
            do {
                let actions = try JSONDecoder().decode([Promotion].self, from: response.data)
                completion(actions)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    func getDetailedAction(action_id: Int,_ completion: @escaping (Promotion)-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.actionDetail(actionId: action_id), success: { (response) in
            do {
                let action = try JSONDecoder().decode(Promotion.self, from: response.data)
                completion(action)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    //MARK: Tutors
    func getTutors(_ completion: @escaping (PaginatedTutor)-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.tutors, success: { (response) in
            do {
                let tutors = try JSONDecoder().decode(PaginatedTutor.self, from: response.data)
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
                let tutors = try JSONDecoder().decode([Tutor].self, from: response.data)
                completion(tutors)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
    func getDetailedTutor(tutor_id: Int,_ completion: @escaping (DetailedTutor)-> Void, showError: @escaping (String)-> Void) {
        self.request(target: NetworkManager.tutorsDetail(tutorId: tutor_id), success: { (response) in
            do {
                let tutor = try JSONDecoder().decode(DetailedTutor.self, from: response.data)
                completion(tutor)
            }
            catch {
                showError(Constants.Network.ErrorMessage.CANT_PARSE_DATA)
            }
        }, error: showError)
    }
}

