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
    
    var dataSource = [String : Model]()
    var currentCity : Model!
    var cities : [String]!
    var currentLocationWeather : String?
    
    func setupView() {
        tableView.alwaysBounceVertical = false
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.crimson
        
        tableView.register(SavedLocationsCell.self, forCellReuseIdentifier: Cells.savedLocationsCell)
        tableView.register(AddLocationCell.self, forCellReuseIdentifier: Cells.addLocationsCell)
        tableView.register(ChangeLocationCell.self, forCellReuseIdentifier: Cells.changeLocationCell)
        tableView.register(SelectedLocationsCell.self, forCellReuseIdentifier: Cells.selectedLocationCell)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonPressed(sender:)))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.crimson], for: .normal)
        
        navigationItem.title = "Selected locations"
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
        currentLocationWeather = currentCity != nil ? currentCity.list[0].weather[0].main : "Clear"
        
        if currentCity != nil {
            Converter.shared.weatherList = currentCity.list[0]
            cell.cityTitle = currentCity.city.name
            cell.iconImage = UIImage(named: currentLocationWeather!)
            cell.tempTitle = Converter.shared.temp
            cell.background = UIImage.backgroundImage(currentLocationWeather!)
        } else {
            cell.cityTitle = UserSettings.shared.currentSettings.currentPlace ?? "Current city"
        }
        return cell
    }
    
    func setupLocationCell (itemCell : SavedLocationsCell,indexPath : IndexPath) -> UITableViewCell {
        itemCell.cityTitle = cities[currentIndex(indexPath: indexPath)]
        
        if !dataSource.isEmpty {
            let source = dataSource[cities[currentIndex(indexPath: indexPath)]]!
            itemCell.iconImage = UIImage(named: source.list[0].weather[0].main)
            Converter.shared.weatherList = source.list[0]
            Converter.shared.modelList = source.city
            itemCell.tempTitle = Converter.shared.temp
            itemCell.timeTitle = Converter.shared.timezoneTime
            itemCell.background = UIImage.backgroundImage(source.list[0].weather[0].main)
        }
        
        return itemCell
    }
    
    func currentIndex (indexPath : IndexPath) -> Int {
        return indexPath.row - 4
    }
    
    // MARK: Actions
    
    func addCellPressed () {
        let pushController = CountriesListController(country: String(), changeDefaultLocation: false)
        self.navigationController?.pushViewController(pushController, animated: true)
    }
    
    @objc func editButtonPressed(sender: UIBarButtonItem) {
        if tableView.isEditing {
            tableView.setEditing(false, animated: true)
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editButtonPressed(sender:)))
        } else {
            tableView.setEditing(true, animated: true)
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(editButtonPressed(sender:)))
        }
        
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.crimson], for: .normal)
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
            itemCell.background = UIImage(named: "\(currentLocationWeather!) background")
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
        case 0:
            presentCityWeather(city: UserSettings.shared.currentSettings.currentPlace ?? "")
        case 1:
            let viewController = CountriesListController(country: String(), changeDefaultLocation: true)
            self.navigationController?.pushViewController(viewController, animated: true)
        case 2:
            break
        case 3:
            addCellPressed()
        default:
            presentCityWeather(city: cities[currentIndex(indexPath: indexPath)])
        }
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            UserSettings.shared.currentSettings.savedLocations.remove(at: currentIndex(indexPath: indexPath))
            cities.remove(at: currentIndex(indexPath: indexPath))
            self.tableView.reloadData()
        }
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row > 3
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return indexPath.row > 3
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        UserSettings.shared.currentSettings.savedLocations.swapAt(currentIndex(indexPath: sourceIndexPath), currentIndex(indexPath: destinationIndexPath))
    }
    
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        return proposedDestinationIndexPath.row < 4 ? sourceIndexPath : proposedDestinationIndexPath
    }
    
}

extension SavedLocationViewController {
    
    struct Cells {
        static let savedLocationsCell = "savedLocationsCell"
        static let addLocationsCell = "addLocationsCell"
        static let changeLocationCell = "changeLocationCell"
        static let selectedLocationCell = "selectedLocationCell"
    }
}
