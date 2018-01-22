//
//  CourseAddress.swift
//  BishkekCourses
//
//  Created by Khasanza on 1/19/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import Foundation
import MapKit
import Contacts

class CourseAddress: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.coordinate = coordinate
        super.init()
    }
    var subtitle: String? {
        return locationName
    }
    func mapItem() -> MKMapItem {
        let addresssDictionary = [String(CNPostalAddressStreetKey) : title!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addresssDictionary)
        let mapItem =  MKMapItem(placemark: placemark)
        mapItem.name = "\(title!)"
        return mapItem
    }
}
