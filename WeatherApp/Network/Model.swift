//
//  Model.swift
//  WeatherApp
//
//  Created by Marentilo on 21.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import Foundation

// MARK: - Model
struct Model: Codable {
    let cod : String
    let list: [List]
    let city: City
}

// MARK: - City
struct City: Codable {
    let name: String
    let sunrise, sunset: Double
    let timezone : Int
}

// MARK: - List
struct List: Codable {
    let dt: Double
    let main: Main
    let weather: [Weather]
    let wind: Wind
    let dtTxt: String

    enum CodingKeys: String, CodingKey {
        case dt, main, weather, wind
        case dtTxt = "dt_txt"
    }
}

// MARK: - Main
struct Main: Codable {
    let temp, feelsLike, tempMin, tempMax: Double
    let pressure, seaLevel, grndLevel, humidity: Int

    enum CodingKeys: String, CodingKey {
        case temp
        case feelsLike = "feels_like"
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
    }
}

// MARK: - Weather
struct Weather: Codable {
    let main: String
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
    let deg: Double
}

