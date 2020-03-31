//
//  SettingsViewController.swift
//  WeatherApp
//
//  Created by Marentilo on 21.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {
    
    private let settingsList = [UserSettings.Constants.temperature,
                                UserSettings.Constants.wind,
                                UserSettings.Constants.pressure,
                                UserSettings.Constants.timeformat,
                                UserSettings.Constants.mainLocation,
                                UserSettings.Constants.aboutApp]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    func setupView () {
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.black]
        
        tableView.alwaysBounceVertical = false
        navigationItem.title = "Settings"
        navigationItem.largeTitleDisplayMode = .always
        tableView.register(SettingsCell.self, forCellReuseIdentifier: Cells.settingsCell)
        tableView.register(MainLocationCell.self, forCellReuseIdentifier: Cells.mainLocationCell)
        tableView.register(AboutAppCell.self, forCellReuseIdentifier: Cells.aboutAppCell)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell
        let source = settingsList[indexPath.row]
        
        if source == UserSettings.Constants.aboutApp {
            let itemCell = tableView.dequeueReusableCell(withIdentifier: Cells.aboutAppCell) as! AboutAppCell
            itemCell.aboutAppTitle = source
            cell = itemCell
        } else if source == UserSettings.Constants.mainLocation {
            let itemCell = tableView.dequeueReusableCell(withIdentifier: Cells.mainLocationCell) as! MainLocationCell
            itemCell.infoTitle = source
            itemCell.locationTitle = UserSettings.shared.currentSettings.currentPlace ?? "--:--"
            cell = itemCell
        } else {
            let itemCell = tableView.dequeueReusableCell(withIdentifier: Cells.settingsCell) as! SettingsCell
            itemCell.settingsTitle = settingsList[indexPath.row]
            cell = itemCell
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

}

// MARK: - Information about cells

extension SettingsViewController {
    struct Cells {
        static let settingsCell = "SettingsCell"
        static let aboutAppCell = "AboutAppCell"
        static let mainLocationCell = "MainLocationCell"
    }
}
