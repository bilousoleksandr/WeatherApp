//
//  UserSettings.swift
//  WeatherApp
//
//  Created by Marentilo on 21.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

final class UserSettings{
    
    static let shared = UserSettings()

    private let userDefaults = UserDefaults.standard
    private init() {}
    

    var currentSettings : SettingsModel {
        get {
            guard let data = userDefaults.data(forKey: Constants.currentSettings), let savedSettings = try? JSONDecoder().decode(SettingsModel.self, from: data) else {
                return SettingsModel(temperatureValue: 0, pressureValue: 0, timeValue: 0, windSpeedValue: 0, savedLocations: [String]())
            }
            return savedSettings
        }
        set {
            guard let data = try? JSONEncoder().encode(newValue) else { return }
            userDefaults.setValue(data, forKey: Constants.currentSettings)
        }
    }
       
    var timeValue : Int {
        get { return currentSettings.timeValue}
        set { currentSettings.timeValue = newValue}
    }
    
    var temperatureValue : Int {
        get { return currentSettings.temperatureValue}
        set { currentSettings.temperatureValue = newValue}
    }
    
    var pressureValue : Int {
        get { return currentSettings.pressureValue}
        set { currentSettings.pressureValue = newValue}
    }
    
    var windSpeedValue : Int {
        get { return currentSettings.windSpeedValue}
        set { currentSettings.windSpeedValue = newValue}
    }
    
    var savedLocations : [String] {
        get { return currentSettings.savedLocations}
        set { currentSettings.savedLocations = newValue }
    }
    
}

// MARK: - Constants

extension UserSettings {
    enum Constants {
        static let currentSettings = "currentSettings"
        static let temperature = "Temperature"
        static let wind = "Wind speed"
        static let pressure = "Pressure"
        static let timeformat = "Time Format"
        static let mainLocation = "Main location"
        static let aboutApp = "Weather app"
    }
    
    enum UnitsDefauls : Int{
        case metric = 0
        case imperial = 1
    }
}
