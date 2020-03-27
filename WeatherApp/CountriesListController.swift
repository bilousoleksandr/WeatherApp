//
//  LaunchController.swift
//  WeatherApp
//
//  Created by Marentilo on 24.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

class CountriesListController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
            setupView()
    }
    
    private let addButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Add new location", for: .normal)
        button.titleLabel?.textColor = UIColor.green
        
        return button
    }()
    
    private var citiesList : [String] {
        if let path = Bundle.main.path(forResource: "Cities", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let request = jsonResult[country] as? [String] {
                    return request
                            // do stuff
                  }
              } catch {
                   // handle error
                print("error")
              }
        }
        return [String]()
    }

    private var sections : [Section]!
    private var country : String!
    private var changeDefaultLocation : Bool
    
    private let countriesList : [String] = {
        if let path = Bundle.main.path(forResource: "country-by-name", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                let countries = try JSONDecoder().decode(CountriesModel.self, from: data)
                
                var result = [String]()
                for item in countries {
                    result.append(item.country)
                }
                
                return result
              } catch {
                    print("error")
              }
        }
        return [String]()
    } ()
    
    init(country : String, changeDefaultLocation : Bool) {
        self.country = country
        self.changeDefaultLocation = changeDefaultLocation
        super.init(nibName: nil, bundle: nil)
    }
    
    
    required init?(coder: NSCoder) {
        self.country = String()
        self.changeDefaultLocation = false
        super.init(coder: coder)
    }
    
    func devideIntoSections (source: [String], withTerm term: String) -> [Section] {
        var sections = [Section]()
        
        if source.count == 0 {
            return sections
        }
        
        var currentLetter = String(source[0].first!)
        var section = Section(name: currentLetter, items: [String]())

        
            for name in source {
                if !name.contains(term) && term.count > 0 {
                    continue
                }
                                
                if String(name.first!) == currentLetter {
                    section.items.append(name)
                } else {
                    sections.append(section)
                    currentLetter = String(name.first!)
                    section = Section(name: currentLetter, items: [name])
                }
            }
        sections.append(section)
        
    
        return sections
    }
    
    func setupView() {
        tableView.alwaysBounceVertical = false
        sections = country.isEmpty ? devideIntoSections(source: countriesList, withTerm: "") : devideIntoSections(source: citiesList, withTerm: "")
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Cells.basicCell)
        navigationItem.title = country.isEmpty ? "Select country" : country
        
        navigationItem.searchController = UISearchController()
        navigationItem.searchController?.searchBar.delegate = self
        
                
    }
 
 // MARK: - UITableViewDataSource

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Cells.basicCell)
        
        let source = sections[indexPath.section].items
        cell?.textLabel?.text = source[indexPath.row]
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].name
    }
    
    override func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        return sections.compactMap{$0.name}
    }
    
    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let controller : UIViewController
        if country.isEmpty {
            controller = CountriesListController(country: tableView.cellForRow(at: indexPath)?.textLabel?.text ?? "nil", changeDefaultLocation: changeDefaultLocation)
            self.navigationController?.pushViewController(controller, animated: true)
        } else if !country.isEmpty && changeDefaultLocation {
            UserSettings.shared.currentSettings.currentPlace = tableView.cellForRow(at: indexPath)?.textLabel?.text ?? "nil"
            print(UserSettings.shared.currentSettings.currentPlace ?? "nil")
            let newController = ViewController(city: UserSettings.shared.currentSettings.currentPlace)
            self.navigationController?.pushViewController(newController, animated: true)
        } else {
            let city = tableView.cellForRow(at: indexPath)?.textLabel?.text ?? "nil"
            UserSettings.shared.currentSettings.savedLocations.append(city)

            let newController = ViewController(city: city)
            newController.navigationItem.title = tableView.cellForRow(at: indexPath)?.textLabel?.text
            self.navigationController?.pushViewController(newController, animated: true)
        }
        
    }
}

// MARK: - Model for JSON Parsing

extension CountriesListController {
    
    struct Countries: Codable {
        let country: String
    }
    
    typealias CountriesModel = [Countries]
    
    private struct Cells {
        static let basicCell = "basicCell"
    }
}

// MARK: - UISearchBarDelegate

extension CountriesListController : UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        sections = devideIntoSections(source: country.isEmpty ? countriesList : citiesList, withTerm: searchText)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        sections = devideIntoSections(source: country.isEmpty ? countriesList : citiesList, withTerm: "")
        tableView.reloadData()
    }
}
