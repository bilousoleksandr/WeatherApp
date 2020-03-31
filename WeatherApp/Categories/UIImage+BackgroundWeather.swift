//
//  UIImage+BackGroundWeather.swift
//  WeatherApp
//
//  Created by Marentilo on 31.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

extension UIImage {
    static func backgroundImage (_ weatherDescription: String) -> UIImage {
        return UIImage(named: weatherDescription + " background") ?? UIImage()
    }
    
    enum WeatherConditions {
        static let sunrise = UIImage(named: "sunrise")
        static let sunset = UIImage(named: "sunset")
        static let wind = UIImage(named: "wind")
        static let direction = UIImage(named: "direction")
        static let pressure = UIImage(named: "pressure")
        static let humidity = UIImage(named: "humidity")
        static let satellite = UIImage(named: "satellite")
        static let defaultImage = UIImage(named: "default")
    }
    
    enum Navigation {
        static let add = UIImage(named: "add")
        static let placeholder = UIImage(named: "placeholder")
        static let menu = UIImage(named: "menu")
        static let settings = UIImage(named: "settings")
    }
    
}
