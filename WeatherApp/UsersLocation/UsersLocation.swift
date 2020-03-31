//
//  UsersLocation.swift
//  WeatherApp
//
//  Created by Marentilo on 22.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit
import CoreLocation

final class UsersLocation : NSObject{
    
    lazy var locationManager : CLLocationManager = {
        let locManager = CLLocationManager()
        locManager.delegate = self
        return locManager
    } ()
    
    var location : CLLocation!
    var city : String!
    var status : CLAuthorizationStatus!
    
    var delegate : UsersLocationDelegate?
    
    private override init () {
        super.init()
    }
    
    public static let shared = UsersLocation()

    private let geocoder = CLGeocoder()
    
    
    func getCityName (onSuccess: @escaping (String) -> (), onFailure: @escaping (Error?) -> ()) {
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            guard error == nil else {
                onFailure(error)
                return }
            if let items = placemarks, items.count > 0 {
                let placemark = items.last!
                self.city = placemark.locality ?? "Not found"
                onSuccess(self.city)
            } else {
                print("No placemarks found")
            }
        }
    }
    
}

// MARK: - CLLocationManagerDelegate

extension UsersLocation : CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.last!
        delegate?.locationManager(manager, didUpdateUserLocation : locations)
        manager.stopUpdatingHeading()
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        if status == .authorizedWhenInUse || status == .authorizedAlways {
            locationManager.startUpdatingLocation()
        }
        self.status = status
        delegate?.locationManager(manager, didChangeStatus: status)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        delegate?.locationManager(manager, didFailToUpdate: error)
    }
    
}
