//
//  ViewController.swift
//  WeatherApp
//
//  Created by Marentilo on 21.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    private let settingsList = ["Temperature", "Wind speed", "Pressure", "Feeling like", "About app"]
    private let query = QueryService.shared
    private var city : String!
    private var source : Model!
    
    init(city : String?) {
        self.city = city ?? String()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

    private struct Cells {
        static let scrollingCell = "ScrollingTableViewCell"
        static let staticCell = "StaticSettingsCell"
        static let mainScreenCell = "MainScreenCell"
        static let userLocationdDisabledCell = "userLocationdDisabledCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    lazy var alertController : UIAlertController = {
        let alert = UIAlertController(title: "Warning", message: "Can't get data for \(city ?? "city")", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
            self.showAllLocations()
        }))
        return alert
    } ()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if source != nil {
            tableView.reloadData()
        }

    }
    
    private let settingsButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "settings"), for: .normal)
        return button
    } ()
    
    private let menuButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "menu"), for: .normal)
        return button
    } ()

    func setupView() {
        loadData()
        view.addSubview(settingsButton)
        navigationItem.largeTitleDisplayMode = .always
        
        settingsButton.addTarget(self, action: #selector(settingButtonPressed(sender:)), for: .touchUpInside)
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: settingsButton)
        
        menuButton.addTarget(self, action: #selector(menuButtonPressed(sender:)), for: .touchUpInside)
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: menuButton)

        tableView.register(MainScreenCell.self, forCellReuseIdentifier: Cells.mainScreenCell)
        tableView.register(StaticSettingsCell.self, forCellReuseIdentifier: Cells.staticCell)
        tableView.register(ScrollingTableViewCell.self, forCellReuseIdentifier: Cells.scrollingCell)
        tableView.register(UserLocationDisabledCell.self, forCellReuseIdentifier: Cells.userLocationdDisabledCell)
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(refreshControlAction(sender:)), for: .valueChanged)
    }
    
    func loadData () {
        self.query.getSearchResults(withTerm: self.city!, onSuccess: { [weak self] response in
            DispatchQueue.main.async() {
                self?.source = response
                self?.tableView.reloadData()
                self?.navigationItem.title = response.city.name
            }
        }, onFailure: { [weak self] error in
            if UserSettings.shared.currentSettings.currentPlace != nil {
                DispatchQueue.main.async {
                    self?.present(self!.alertController, animated: true, completion: nil)
                }
                UserSettings.shared.currentSettings.savedLocations.popLast()
            }
        })
    }
    
    
    func setupMainCell (cell : MainScreenCell) -> UITableViewCell {
            let dataSource = source.list.first!
            WeatherConverter.shared.weatherList = dataSource
            WeatherConverter.shared.modelList = query.weatherModel.city
            cell.temperatureTitle = "\(WeatherConverter.shared.temp)"
            cell.feelingTitle = "\(WeatherConverter.shared.feelsTemp)"
            cell.sunsetTitle = WeatherConverter.shared.sunset
            cell.sunriseTitle = WeatherConverter.shared.sunrise
                
            cell.weatherDescriptionTitle = dataSource.weather[0].main
            cell.iconImage = UIImage(named: dataSource.weather[0].main)
            
            cell.windTitle = WeatherConverter.shared.windSpeed
            cell.windDirectionTitle = WeatherConverter.shared.windDirect
            cell.pressureTitle = "\(WeatherConverter.shared.pressure)"
            cell.humidityTitle = "\(dataSource.main.humidity)"
        
        return cell
    }
    
    func setupStaticCell (cell : StaticSettingsCell, indexPath: IndexPath) -> StaticSettingsCell {
        if source != nil {
            let source = query.fiveDays[indexPath.row - 2]
            WeatherConverter.shared.weatherList = source
            cell.dayOfMonthTitle = WeatherConverter.shared.dayOfMonth
            cell.dayOfWeekTitle = WeatherConverter.shared.currentDayOfWeek
            cell.minTempTitle = "\(WeatherConverter.shared.minTemp)"
            cell.maxTempTitle = "\(WeatherConverter.shared.maxTemp)"
            cell.iconImage = UIImage(named: source.weather[0].main)
        } else {
            let source = WeatherConverter.shared.fiveDays[indexPath.row - 2]
            WeatherConverter.shared.currentDayAndTime = source
            cell.dayOfMonthTitle = WeatherConverter.shared.dayOfMonth
            cell.dayOfWeekTitle = WeatherConverter.shared.currentDayOfWeek
        }

        return cell
    }
    
    func showAllLocations () {
        DispatchQueue.main.async {
            let pushController = SavedLocationViewController()
            let navController = UINavigationController(rootViewController: pushController)
            navController.modalPresentationStyle = .overFullScreen

            self.present(navController, animated: true, completion: nil)
        }

    }
    
    // MARK: - Actions
    
    @objc func refreshControlAction(sender: UIRefreshControl) {
        loadData()
        DispatchQueue.main.async {
           self.tableView.refreshControl?.endRefreshing()
        }
    }
    
    @objc func settingButtonPressed(sender: UIBarButtonItem) {
        let pushController = SettingsViewController()
        self.navigationController?.pushViewController(pushController, animated: true)
    }
    
    @objc func menuButtonPressed(sender: UIBarButtonItem) {
        showAllLocations()
    }
    
        // MARK: - UITableViewDataSource
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        
        if indexPath.row == 0 {
            cell = source != nil ? setupMainCell(cell: tableView.dequeueReusableCell(withIdentifier: Cells.mainScreenCell) as! MainScreenCell) : tableView.dequeueReusableCell(withIdentifier: Cells.userLocationdDisabledCell) as! UserLocationDisabledCell
        } else if indexPath.row == 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: Cells.scrollingCell) as! ScrollingTableViewCell
        } else {
            cell = setupStaticCell(cell: tableView.dequeueReusableCell(withIdentifier: Cells.staticCell) as! StaticSettingsCell, indexPath: indexPath)
        }

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    // MARK: - UITableViewControllerDelegate
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return indexPath.row == 1 ? 140 : UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if cell is ScrollingTableViewCell {
            (cell as! ScrollingTableViewCell).collectionView.reloadData()
        }
    }

}
