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
            citiesList = loadCitiesList()
            setupView()
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "id")
    }
    
    func loadCitiesList () -> [String] {
        if let path = Bundle.main.path(forResource: "Cities", ofType: "json") {
            do {
                  let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                  let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                  if let jsonResult = jsonResult as? Dictionary<String, AnyObject>, let request = jsonResult[country] as? [String] {
                    print(request)
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
        

    
    private var country : String!
    private var citiesList : [String]!
    private var city : String!
    
    private let countriesList : [String] = {
        if let path = Bundle.main.path(forResource: "country-by-name", ofType: "json") {
            do {
                print("hello")
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
    
    init(country : String, cities: [String]) {
        self.citiesList = cities
        self.country = country
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    private let addButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Add new location", for: .normal)
        button.titleLabel?.textColor = UIColor.green
        
        return button
    }()
    
    func setupView() {
        navigationItem.title = country.isEmpty ? "Choose new country" : country

//        [
//            addButton
//        ].forEach{
//            $0.translatesAutoresizingMaskIntoConstraints = false
//            view.addSubview($0)
//        }
//        addButton.addTarget(self, action: #selector(addButtonPressed(sender:)), for: .touchUpInside)
//        setupConstraints()
    }
    
    func setupConstraints() {
        let constraint = [
            addButton.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            addButton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ]
        
        NSLayoutConstraint.activate(constraint)
        
    }
    
    @objc func addButtonPressed (sender : UIButton) {
        let newNavigation = ViewController()
        self.navigationController?.pushViewController(newNavigation, animated: true)
    }

 // MARK: - UITableViewDataSource

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return country.isEmpty ? countriesList.count : citiesList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id")
        cell?.textLabel?.text = country.isEmpty ? countriesList[indexPath.row] : citiesList[indexPath.row]
        return cell!
    }
    // MARK: - UITableViewDelegate

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if country.isEmpty {
            let newController = CountriesListController(country: tableView.cellForRow(at: indexPath)?.textLabel?.text ?? String(), cities: [String]())
            self.navigationController?.pushViewController(newController, animated: true)
        } else {
            QueryService.shared.getSearchResults(withTerm: tableView.cellForRow(at: indexPath)?.textLabel?.text ?? String())
            DispatchQueue.global().asyncAfter(deadline: .now() + 0.5) {
                
                DispatchQueue.main.async {
                    let newController = ViewController()
                    newController.navigationItem.title = tableView.cellForRow(at: indexPath)?.textLabel?.text
                    self.navigationController?.pushViewController(newController, animated: true)
                }
            }
        }
    }
}

extension CountriesListController {
    
    struct Countries: Codable {
        let country: String
    }

    typealias CountriesModel = [Countries]
    
    enum CountriesList {
        static let list = ["Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegowina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo", "Congo, the Democratic Republic of the", "Cook Islands", "Costa Rica", "Cote d'Ivoire", "Croatia (Hrvatska)", "Cuba", "Cyprus", "Czech Republic", "Denmark", "Djibouti", "Dominica", "Dominican Republic", "East Timor", "Ecuador", "Egypt", "El Salvador", "Equatorial Guinea", "Eritrea", "Estonia", "Ethiopia", "Falkland Islands (Malvinas)", "Faroe Islands", "Fiji", "Finland", "France", "France Metropolitan", "French Guiana", "French Polynesia", "French Southern Territories", "Gabon", "Gambia", "Georgia", "Germany", "Ghana", "Gibraltar", "Greece", "Greenland", "Grenada", "Guadeloupe", "Guam", "Guatemala", "Guinea", "Guinea-Bissau", "Guyana", "Haiti", "Heard and Mc Donald Islands", "Holy See (Vatican City State)", "Honduras", "Hong Kong", "Hungary", "Iceland", "India", "Indonesia", "Iran (Islamic Republic of)", "Iraq", "Ireland", "Israel", "Italy", "Jamaica", "Japan", "Jordan", "Kazakhstan", "Kenya", "Kiribati", "Korea, Democratic People's Republic of", "Korea, Republic of", "Kuwait", "Kyrgyzstan", "Lao, People's Democratic Republic", "Latvia", "Lebanon", "Lesotho", "Liberia", "Libyan Arab Jamahiriya", "Liechtenstein", "Lithuania", "Luxembourg", "Macau", "Macedonia, The Former Yugoslav Republic of", "Madagascar", "Malawi", "Malaysia", "Maldives", "Mali", "Malta", "Marshall Islands", "Martinique", "Mauritania", "Mauritius", "Mayotte", "Mexico", "Micronesia, Federated States of", "Moldova, Republic of", "Monaco", "Mongolia", "Montserrat", "Morocco", "Mozambique", "Myanmar", "Namibia", "Nauru", "Nepal", "Netherlands", "Netherlands Antilles", "New Caledonia", "New Zealand", "Nicaragua", "Niger", "Nigeria", "Niue", "Norfolk Island", "Northern Mariana Islands", "Norway", "Oman", "Pakistan", "Palau", "Panama", "Papua New Guinea", "Paraguay", "Peru", "Philippines", "Pitcairn", "Poland", "Portugal", "Puerto Rico", "Qatar", "Reunion", "Romania", "Russian Federation", "Rwanda", "Saint Kitts and Nevis", "Saint Lucia", "Saint Vincent and the Grenadines", "Samoa", "San Marino", "Sao Tome and Principe", "Saudi Arabia", "Senegal", "Seychelles", "Sierra Leone", "Singapore", "Slovakia (Slovak Republic)", "Slovenia", "Solomon Islands", "Somalia", "South Africa", "South Georgia and the South Sandwich Islands", "Spain", "Sri Lanka", "St. Helena", "St. Pierre and Miquelon", "Sudan", "Suriname", "Svalbard and Jan Mayen Islands", "Swaziland", "Sweden", "Switzerland", "Syrian Arab Republic", "Taiwan, Province of China", "Tajikistan", "Tanzania, United Republic of", "Thailand", "Togo", "Tokelau", "Tonga", "Trinidad and Tobago", "Tunisia", "Turkey", "Turkmenistan", "Turks and Caicos Islands", "Tuvalu", "Uganda", "Ukraine", "United Arab Emirates", "United Kingdom", "United States", "United States Minor Outlying Islands", "Uruguay", "Uzbekistan", "Vanuatu", "Venezuela", "Vietnam", "Virgin Islands (British)", "Virgin Islands (U.S.)", "Wallis and Futuna Islands", "Western Sahara", "Yemen", "Yugoslavia", "Zambia", "Zimbabwe"]
    }
    
}
