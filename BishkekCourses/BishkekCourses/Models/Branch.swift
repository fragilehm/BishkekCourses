//
//  Branch.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/8/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Branch {
    var address: String
    var latitude: String
    var longitude: String

    init() {
        address = ""
        latitude = ""
        longitude = ""
    }
    
    init(json: JSON) {
        address = json["address"].stringValue
        latitude = json["latitude"].stringValue
        longitude = json["longitude"].stringValue
    }
}

class Branches: NSObject {
    var array: Array = Array<Branch>()
    override init() {
    }
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Branch(json:json)
            array.append(tempObject)
        }
    }
}

