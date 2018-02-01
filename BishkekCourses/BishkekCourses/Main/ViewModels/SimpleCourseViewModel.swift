//
//  SimpleCourseViewModel.swift
//  BishkekCourses
//
//  Created by Khasanza on 2/1/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Moya
import Moya_ModelMapper
class SimpleCourseViewModel {
    let simpleCourses = Variable<[SimpleCourse]>([])
    let error: Variable<String>? = nil
    func fetchData () {
        ServerAPIManager.sharedAPI.getRecentCourses({ [weak self] (recentCourses) in
            self?.simpleCourses.value = recentCourses
        }) { (errorMessage) in
            self.error?.value = errorMessage
        }
    }
}
