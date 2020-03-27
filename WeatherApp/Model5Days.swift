//
//  Model5Days.swift
//  WeatherApp
//
//  Created by Marentilo on 23.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import Foundation

struct WeatherFor5Days: Codable {
    let list: [List]
    
    // MARK: - List
    struct List: Codable {
        let dt: Double
        let main: Main
        let weather: [Weather]
        let dtTxt: String

        enum CodingKeys: String, CodingKey {
            case dt, main, weather
            case dtTxt = "dt_txt"
        }
    }

    // MARK: - Main
    struct Main: Codable {
        let tempMin, tempMax: Double

        enum CodingKeys: String, CodingKey {
            case tempMin = "temp_min"
            case tempMax = "temp_max"
        }
    }

    // MARK: - Weather
    struct Weather: Codable {
        let weatherDescription: String

        enum CodingKeys: String, CodingKey {
            case weatherDescription = "description"
        }
    }
}


