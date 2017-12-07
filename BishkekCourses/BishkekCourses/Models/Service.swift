//
//  Service.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/8/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//
import Foundation
import SwiftyJSON

struct Service {
    var title: String
    var description: String
    var price: Int
    
    init() {
        title = ""
        description = ""
        price = 0
    }
    
    init(json: JSON) {
        title = json["title"].stringValue
        description = json["description"].stringValue
        price = json["price"].intValue
    }
}

class Services: NSObject {
    var array: Array = Array<Service>()
    override init() {
    }
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Service(json:json)
            array.append(tempObject)
        }
    }
}


