//
//  LocationManager.swift
//  SwiftUI-SC
//
//  Created by Babul Raj on 03/04/22.
//

import Foundation
import CoreLocation


class WetherLocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    
    var manager: CLLocationManager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    @Published var isLoading: Bool = false
    
    override init() {
        super.init()
        manager.delegate = self
    }
    
    func requestLocation() {
        isLoading = true
        manager.requestLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.first?.coordinate
        isLoading = false
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        isLoading = false
    }
}
