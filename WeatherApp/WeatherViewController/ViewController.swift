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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        if source != nil {
            tableView.reloadData()
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.setBackgroundImage(nil, for: .default)
        self.navigationController?.navigationBar.shadowImage = nil
        self.navigationController?.navigationBar.isTranslucent = false
    }
    
    private let settingsButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.Navigation.settings, for: .normal)
        return button
    } ()
    
    private let menuButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage.Navigation.menu, for: .normal)
        return button
    } ()

    func setupView() {
        loadData()
        
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem?.tintColor = UIColor.crimson
        
        tableView.contentInset = UIEdgeInsets(top: -(UIApplication.shared.statusBarFrame.height + (navigationController?.navigationBar.bounds.height ?? 0)) , left: 0, bottom: 0, right: 0)
        view.addSubview(settingsButton)
        
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
                self?.navigationItem.title = response.city.name
                self?.tableView.reloadData()
            }
        }, onFailure: { error in
            print(error.localizedDescription)
        })
    }
    
    
    func setupMainCell (cell : MainScreenCell) -> UITableViewCell {
            let dataSource = source.list.first!
            Converter.shared.weatherList = dataSource
            Converter.shared.modelList = query.weatherModel.city
            cell.temperatureTitle = "\(Converter.shared.temp)"
            cell.feelingTitle = "\(Converter.shared.feelsTemp)"
            cell.sunsetTitle = Converter.shared.sunset
            cell.sunriseTitle = Converter.shared.sunrise
        
            cell.weatherDescriptionTitle = dataSource.weather[0].main
            cell.iconImage = UIImage(named: dataSource.weather[0].main)
            cell.backgroundImage = UIImage.backgroundImage(dataSource.weather[0].main)
    
            cell.windTitle = Converter.shared.windSpeed
            cell.windDirectionTitle = Converter.shared.windDirect
            cell.pressureTitle = "\(Converter.shared.pressure)"
            cell.humidityTitle = "\(dataSource.main.humidity)"
        
        return cell
    }
    
    func setupStaticCell (cell : StaticSettingsCell, indexPath: IndexPath) -> StaticSettingsCell {
        if source != nil {
            let source = query.fiveDays[indexPath.row - 2]
            Converter.shared.weatherList = source
            cell.dayOfMonthTitle = Converter.shared.dayOfMonth
            cell.dayOfWeekTitle = Converter.shared.currentDayOfWeek
            cell.minTempTitle = "\(Converter.shared.minTemp)"
            cell.maxTempTitle = "\(Converter.shared.maxTemp)"
            cell.iconImage = UIImage(named: source.weather[0].main)
        } else {
            let source = Converter.shared.fiveDays[indexPath.row - 2]
            Converter.shared.currentDayAndTime = source
            cell.dayOfMonthTitle = Converter.shared.dayOfMonth
            cell.dayOfWeekTitle = Converter.shared.currentDayOfWeek
        }

        return cell
    }
    
    func setupScrollingCells (cell : ScrollingTableViewCell) {
        if source != nil {
            cell.dataSource = source.list
        } else {
            cell.emptyDataSource = Converter.shared.twentyThreeHourItems
        }
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
            let itemCell = tableView.dequeueReusableCell(withIdentifier: Cells.scrollingCell) as! ScrollingTableViewCell
            setupScrollingCells(cell: itemCell)
            cell = itemCell
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
