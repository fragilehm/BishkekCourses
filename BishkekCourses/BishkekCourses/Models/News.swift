//
//  News.swift
//  BishkekCourses
//
//  Created by Khasanza on 4/13/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
struct News: Decodable {
    var id: Int
    var title: String
    var description: String
    var added: String?
    var news_image: String
}
