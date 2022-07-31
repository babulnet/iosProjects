//
//  LocationManager.swift
//  SwiftUIPractice
//
//  Created by Babul Raj on 30/05/22.
//

import Foundation
import CoreLocation

class LocationManager:NSObject, ObservableObject,CLLocationManagerDelegate {
    var manager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    @Published var isloading = false
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        isloading = true
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        isloading = false
        self.location = locations.first?.coordinate
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        isloading = false
    }
}
