//
//  Images.swift
//  BishkekCourses
//
//  Created by Khasanza on 12/8/17.
//  Copyright © 2017 Khasanza. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Images {
    var main_image_url: String
    var logo_image_url: String
    var background_image_url: String
    
    init() {
        main_image_url = ""
        logo_image_url = ""
        background_image_url = ""
    }
    init(json: JSON) {
        main_image_url = json["main_image_url"].stringValue
        logo_image_url = json["logo_image_url"].stringValue
        background_image_url = json["background_image_url"].stringValue
    }
}
class Imagess: NSObject {
    var array: Array = Array<Images>()
    override init() {
    }
    init(json: JSON) {
        let jsonArr:[JSON] = json.arrayValue
        for json in jsonArr {
            let tempObject = Images(json:json)
            array.append(tempObject)
        }
    }
}



