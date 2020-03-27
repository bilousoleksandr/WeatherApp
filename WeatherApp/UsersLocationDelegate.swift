//
//  UsersLocationDelegate.swift
//  WeatherApp
//
//  Created by Marentilo on 26.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import Foundation
import CoreLocation


protocol UsersLocationDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailToUpdate error: Error)
        
    func locationManager(_ manager: CLLocationManager, didUpdateUserLocation : [CLLocation])
    
    func locationManager(_ manager: CLLocationManager, didChangeStatus status: CLAuthorizationStatus)
}
