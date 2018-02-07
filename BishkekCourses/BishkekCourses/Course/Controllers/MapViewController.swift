//
//  MapViewController.swift
//  BishkekCourses
//
//  Created by Khasanza on 1/17/18.
//  Copyright © 2018 Khasanza. All rights reserved.
//

import UIKit
import MapKit
class MapViewController: UIViewController {
    private let locationManager = CLLocationManager()
    private let regionRadius: CLLocationDistance = 1000
    @IBOutlet weak var mapView: MKMapView!
    var branches = [Branch]()
    var branch_id = 0
    var branch_title = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setupMapKit()
    }
    override func viewDidAppear(_ animated: Bool) {
        enableLocationServices()
    }
    
    func setupMapKit(){
        mapView.mapType = .standard
        //let locationOfBishkek = CLLocation(latitude: 42.874722, longitude: 74.612222)
        mapView.delegate = self
        //let annotationId = "AnnotationIdentifier"
        for (index, branch) in branches.enumerated() {
            let address = CourseAddress(title: branch.address, locationName: "", coordinate: CLLocationCoordinate2D(latitude: (branch.latitude as NSString).doubleValue , longitude: (branch.longitude as NSString).doubleValue))
            if index == branch_id {
                centerMapOnLocation(location: CLLocation(latitude: (branch.latitude as NSString).doubleValue, longitude: (branch.longitude as NSString).doubleValue))
            }
            mapView.addAnnotation(address)
        }
        let currentLocationButton = MKUserTrackingBarButtonItem(mapView: mapView)
        self.navigationItem.rightBarButtonItem = currentLocationButton
    }
    func centerMapOnLocation(location: CLLocation) {
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate,
                                                                  regionRadius * 2.0, regionRadius * 2.0)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    func enableLocationServices() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        switch CLLocationManager.authorizationStatus() {
        case .notDetermined:
            // Request when-in-use authorization initially
            locationManager.requestWhenInUseAuthorization()
            locationManager.startUpdatingLocation()
            break
        case .restricted, .denied:
            // Disable location features
            print("disableMyLocationBasedFeatures()")
            break
            
        case .authorizedWhenInUse:
            // Enable basic location features
            mapView.showsUserLocation = true
            locationManager.startUpdatingLocation()

            print("enableMyWhenInUseFeatures()")
            break
            
        case .authorizedAlways:
            // Enable any of your app's location features
            print("enableMyAlwaysFeatures()")
            break
        }
    }
    
}
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.mapView.showsUserLocation = true
    }
}
extension MapViewController: MKMapViewDelegate{
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if let annotation = annotation as? CourseAddress {
            let annotation_id = "pin"
            if #available(iOS 11.0, *) {
                var view: MKMarkerAnnotationView

                if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation_id) as? MKMarkerAnnotationView{
                    dequeuedView.annotation = annotation
                    view = dequeuedView
                }
                else {
                    
                    view = MKMarkerAnnotationView(annotation: annotation, reuseIdentifier: annotation_id)
                    view.canShowCallout = true
                    view.calloutOffset = CGPoint(x: -5, y: 5)
                    view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
                }
                return view
            } else {
                var view: MKPinAnnotationView

                if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: annotation_id) as? MKPinAnnotationView{
                    dequeuedView.annotation = annotation
                    view = dequeuedView
                }
                else {
                    view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: annotation_id)
                    view.canShowCallout = true
                    view.calloutOffset = CGPoint(x: -5, y: 5)
                    view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure) as UIView
                }
                // Fallback on earlier versions
            }
        }
        return nil
    }
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        let location = view.annotation as! CourseAddress
        let launchOptions = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
        location.mapItem().openInMaps(launchOptions: launchOptions)
    }
}
