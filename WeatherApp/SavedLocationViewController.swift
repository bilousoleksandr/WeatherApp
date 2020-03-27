//
//  SavedLocationViewController.swift
//  WeatherApp
//
//  Created by Marentilo on 25.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

class SavedLocationViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.tableView.reloadData()
    }
    
    private let addButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "add"), for: .normal)
        return button
    } ()
    
    private let settingsButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "settings"), for: .normal)
        return button
    } ()
    
    var dataSource = [String : Model]()
    var currentCity : Model!
    var cities : [String]!
    
    func setupView() {
        tableView.alwaysBounceVertical = false
        
        tableView.register(SavedLocationsCell.self, forCellReuseIdentifier: Cells.savedLocationsCell)
        tableView.register(AddLocationCell.self, forCellReuseIdentifier: Cells.addLocationsCell)
        tableView.register(CurrentLocationCell.self, forCellReuseIdentifier: Cells.currentLocationCell)
        tableView.register(ChangeLocationCell.self, forCellReuseIdentifier: Cells.changeLocationCell)
        tableView.register(SelectedLocationsCell.self, forCellReuseIdentifier: Cells.selectedLocationCell)

        settingsButton.addTarget(self, action: #selector(settingButtonPressed(sender:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshControlAction(sender:)), for: .valueChanged)
        
        loadData()
    }

    func loadData () {
        cities = UserSettings.shared.currentSettings.savedLocations
        
        let workItem = DispatchWorkItem {
            if let currentCity = UserSettings.shared.currentSettings.currentPlace {
                QueryService.shared.getSearchResults(withTerm: currentCity, onSuccess: { city in
                    self.currentCity = city
                    if self.cities.count == 0 {
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                        }
                    }
                }, onFailure: { print($0)})
            }
            self.dataSource = [String : Model]()

                for item in self.cities {
                    QueryService.shared.getSearchResults(withTerm: item, onSuccess: { response in
                    DispatchQueue.main.async {
                        self.dataSource[item] = response
                        if self.dataSource.count == self.cities.count {
                            self.tableView.reloadData()
                        }
                        }
                    }, onFailure: { print($0)})
            }
            
        }
        DispatchQueue.global().async(execute: workItem)
    }
    
    func presentCityWeather(city: String) {
        let popupController = ViewController(city: city)
        let navigationController = UINavigationController(rootViewController: popupController)
        navigationController.modalPresentationStyle = .overFullScreen
        let popover = navigationController.popoverPresentationController
        popover?.permittedArrowDirections = .any
        
        present(navigationController, animated: true, completion: nil)
    }
    
    func setupCurrentLocation(cell : SavedLocationsCell) -> UITableViewCell {
        cell.timeTitle = "Current location"
        if currentCity != nil {
            WeatherConverter.shared.weatherList = currentCity.list[0]
            cell.cityTitle = currentCity.city.name
            cell.iconImage = UIImage(named: currentCity.list[0].weather[0].main)
            cell.tempTitle = WeatherConverter.shared.temp
        } else {
            cell.cityTitle = UserSettings.shared.currentSettings.currentPlace ?? "Current city"
        }
        return cell
    }
    
    func setupLocationCell (itemCell : SavedLocationsCell,indexPath : IndexPath) -> UITableViewCell {
        itemCell.cityTitle = cities[indexPath.row - 4]
        
        if !dataSource.isEmpty {
            let source = dataSource[cities[indexPath.row - 4]]!
            itemCell.iconImage = UIImage(named: source.list[0].weather[0].main)
            WeatherConverter.shared.weatherList = source.list[0]
            WeatherConverter.shared.modelList = source.city
            itemCell.tempTitle = WeatherConverter.shared.temp
            itemCell.timeTitle = WeatherConverter.shared.timezoneTime
        }
        
        return itemCell
    }
    
    
    // MARK: Actions
    
    func addCellPressed () {
        let pushController = CountriesListController(country: String(), changeDefaultLocation: false)
        self.navigationController?.pushViewController(pushController, animated: true)
    }
    
    @objc func settingButtonPressed(sender: UIBarButtonItem) {
        let pushController = SettingsViewController()
        self.navigationController?.pushViewController(pushController, animated: true)
    }
    
    @objc func refreshControlAction(sender: UIRefreshControl) {
        loadData()
        DispatchQueue.main.async {
           self.tableView.refreshControl?.endRefreshing()
        }
    }

    
    // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cities.count + 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : UITableViewCell
        
        
        switch indexPath.row {
        case 0:
            let itemCell = tableView.dequeueReusableCell(withIdentifier: Cells.savedLocationsCell) as! SavedLocationsCell
            cell = setupCurrentLocation(cell: itemCell)
        case 1:
            let itemCell = tableView.dequeueReusableCell(withIdentifier: Cells.changeLocationCell) as! ChangeLocationCell
            cell = itemCell
        case 2:
            let itemCell = tableView.dequeueReusableCell(withIdentifier: Cells.selectedLocationCell) as! SelectedLocationsCell
            cell = itemCell
        case 3:
            let itemCell = tableView.dequeueReusableCell(withIdentifier: Cells.addLocationsCell) as! AddLocationCell
            cell = itemCell
        default:
            let itemCell = tableView.dequeueReusableCell(withIdentifier: Cells.savedLocationsCell) as! SavedLocationsCell
            cell = setupLocationCell(itemCell : itemCell, indexPath: indexPath)
        }
        
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch indexPath.row {
        case 0 where UserSettings.shared.currentSettings.currentPlace != nil:
            presentCityWeather(city: UserSettings.shared.currentSettings.currentPlace ?? "nil")
        case 1:
            let viewController = CountriesListController(country: String(), changeDefaultLocation: true)
            self.navigationController?.pushViewController(viewController, animated: true)
        case 2:
            break
        case 3:
            addCellPressed()
        default:
            presentCityWeather(city: cities[indexPath.row - 4])
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            cities.remove(at: indexPath.row - 4)
            UserSettings.shared.currentSettings.savedLocations.remove(at: indexPath.row - 4)
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row > 3
    }
    
}

extension SavedLocationViewController {
    
    struct Cells {
        static let savedLocationsCell = "savedLocationsCell"
        static let addLocationsCell = "addLocationsCell"
        static let currentLocationCell = "currentLocationCell"
        static let changeLocationCell = "changeLocationCell"
        static let selectedLocationCell = "selectedLocationCell"
    }
}
