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
import PKHUD
import KRProgressHUD

class SimpleCourseViewModel {
    let simpleCourses = Variable<[SimpleCourse]>([])
    let error = PublishSubject<String>()
    func fetchData () {
        ServerAPIManager.sharedAPI.getRecentCourses({ [weak self] (recentCourses) in
            KRProgressHUD.dismiss()
            self?.simpleCourses.value = recentCourses
        }) { (errorMessage) in
            KRProgressHUD.dismiss()
            self.error.onNext(errorMessage)
        }
    }
}
