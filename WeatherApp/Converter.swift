//
//  CityWeather.swift
//  WeatherApp
//
//  Created by Marentilo on 23.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import Foundation

final class Converter {
    
    private let dateFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        return formatter
    } ()
    
    private let timezoneFormatter : DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar.current
        return formatter
    } ()
    
    static let shared = Converter()
    
    private init () {}

    private var currentTemperature : Double!
    private var maxTemperature : Double!
    private var minTemperature : Double!
    private var feelsLikeTemperature : Double!
    
    
    private var currentList : List!
    private var currentModel : City!
    
    private var currentDate : Date!
    private var sunriseDate : Date!
    private var sunsetDate : Date!
    private var cityTimezone : Int!
    
    private var currentPressure : Int!
    
    private var currentWind : Double!
    private var windDirection : Double!


    
    var weatherList : List {
        get { return currentList}
        set { currentList = newValue
              currentTemperature = newValue.main.temp
              currentDate = Date(timeIntervalSince1970: newValue.dt)
              maxTemperature = newValue.main.tempMax
              minTemperature = newValue.main.tempMin
              currentWind = newValue.wind.speed
              currentPressure = newValue.main.pressure
              feelsLikeTemperature = newValue.main.feelsLike
              windDirection = newValue.wind.deg
        }
    }
    
    var modelList : City {
        get { return currentModel}
        set {
            currentModel = newValue
            sunriseDate = Date(timeIntervalSince1970: newValue.sunrise)
            sunsetDate = Date(timeIntervalSince1970: newValue.sunset)
            cityTimezone = newValue.timezone
        }
    }
    
    // MARK: - Data when user disallowed location
    
    var currentDayAndTime : Date {
        get {return currentDate}
        set {currentDate = newValue}
    }
    
    var fiveDays : [Date] {
        var array = [Date()]
        let calendar = Calendar.current
        var components = calendar.dateComponents([.day, .year, .month], from: Date())
        
        for _ in 0...3 {
            components.setValue(components.day! + 1, for: .day)
            array.append(calendar.date(from: components)!)
        }
        return array
    }
    
    var twentyThreeHourItems : [Date] {
        var array = [Date]()
        let calendar = Calendar.current
        var components = calendar.dateComponents([.day, .year, .month, .hour, .minute], from: Date())
        components.setValue(0, for: .minute)
        
        for _ in 0...19 {
            components.setValue(components.hour! + 3, for: .hour)
            array.append(calendar.date(from: components)!)
        }
        
        return array
    }
    
    // MARK: - Convert date to format
    
    
    var hours : String {
        dateFormatter.dateFormat = "hh:mm"
        return dateFormatter.string(from: currentDate)
    }
    
    var month : String {
        dateFormatter.dateFormat = "dd MMM"
        return dateFormatter.string(from: currentDate)
    }
    
    var dayOfMonth : String {
        dateFormatter.dateFormat = "dd MMMM"
        return dateFormatter.string(from: currentDate)
    }
    
    var currentDayOfWeek : String{
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: currentDate)
    }
    
    // MARK: - Sunrise and sunset
    
    var sunrise : String {
        currentDate = sunriseDate
        return hoursAndMinutes
    }
    
    var sunset : String {
        currentDate = sunsetDate
        return hoursAndMinutes
    }
    
    // MARK: - Temperature value
    
    var temp : String {
        let result = isMetric(value: UserSettings.shared.temperatureValue) ? currentTemperature : currentTemperature * 9 / 5 + 32
        return String(format: "%.1f°", result!)
    }
    
    var maxTemp : String {
        currentTemperature = maxTemperature
        return temp
    }
    
    var minTemp : String {
        currentTemperature = minTemperature
        return temp
    }
    
    var feelsTemp : String {
        currentTemperature = feelsLikeTemperature
        return "Feeling like " + temp
    }
    
    // MARK: - Metric or imprerial units

    var hoursAndMinutes : String{
        dateFormatter.dateFormat = isMetric(value: UserSettings.shared.timeValue) ? "HH:mm" : "h:mm a"
        return dateFormatter.string(from: currentDate ?? Date())
    }
    
    var windSpeed : String {
        return isMetric(value: UserSettings.shared.windSpeedValue) ? String(format: "%.2f m/s", currentWind) : String(format: "%.2f m/h", currentWind * 2.2369362920544025)
    }
    
    var pressure : String {
        return isMetric(value: UserSettings.shared.pressureValue) ? String(format: "%d hPa", currentPressure) : String(format: "%1.f mm Hg", (Double(currentPressure) / 1.33322387415).rounded() )
    }
    
    var timezoneTime : String {
        let date = Date()
        timezoneFormatter.dateFormat = isMetric(value: UserSettings.shared.timeValue) ? "HH:mm" : "h:mm a"
        timezoneFormatter.timeZone = TimeZone(secondsFromGMT: cityTimezone)
        return timezoneFormatter.string(from: date)
    }
    
    var windDirect : String {
        let result : String
        switch windDirection! {
        case 0:
            result = "North"
        case 0.1...45:
            result = "Northeast"
        case 45.1..<90:
            result = "Eastnorth"
        case 90:
            result = "East"
        case 90.1...135:
            result = "Eastsouth"
        case 135.1..<180:
            result = "Southeast"
        case 180:
            result = "South"
        case 181.1..<225:
               result = "Southwest"
        case 225..<270:
            result = "Westsouth"
        case 270:
            result = "West"
        case 270.1..<315:
            result = "Westnorth"
        case 315..<360:
            result = "Northwest"
        default:
            result = "Northwest"
        }
        return result
    }
    
    func isMetric (value : Int) -> Bool {
        return value == UserSettings.UnitsDefauls.metric.rawValue
    }
    
}

// MARK: - Metric and imperial constants

extension Converter {
    enum Temperature {
        static let metric = "C°"
        static let imperial = "F°"
    }
    
    enum Pressure {
        static let metric = "hPa"
        static let imperial = "mm Hg"
    }
    
    enum TimeFormat {
        static let metric = "24:00"
        static let imperial = "12:00"
    }
    
    enum WindSpeed {
        static let metric = "meter/sec"
        static let imperial = "miles/hour"
    }
}
