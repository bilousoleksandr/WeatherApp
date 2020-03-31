//
//  LaunchViewController.swift
//  WeatherApp
//
//  Created by Marentilo on 26.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit
import CoreLocation

class LaunchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    private let iconView : UIImageView = {
        let icon = UIImageView(frame: CGRect(x: 0, y: 0, width: 256, height: 256))
        icon.setContentHuggingPriority(.required, for: .horizontal)
        icon.setContentCompressionResistancePriority(.required, for: .horizontal)
        icon.image = UIImage(named: "umbrella")
        return icon
    } ()
    
    private let iconLabel : UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "Weather app"
        return label
    } ()

    
    func setupView() {
        view.backgroundColor = UIColor.white
        UsersLocation.shared.delegate = self
        UsersLocation.shared.locationManager.requestAlwaysAuthorization()
        
        [
            iconView,
            iconLabel
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        setupConstrains()
    }
    
    func setupConstrains() {
        let constrains = [
            iconView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            iconLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            iconLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: Space.double * 2)
        ]
        
        NSLayoutConstraint.activate(constrains)
    }
    
    func popEmptyViewController () {
        let newController = ViewController(city: UserSettings.shared.currentSettings.currentPlace)
        self.navigationController?.pushViewController(newController, animated: false)
    }
    
    
}


// MARK: - UsersLocationDelegate

extension LaunchViewController : UsersLocationDelegate {
    
    func locationManager(_ manager: CLLocationManager, didFailToUpdate error: Error) {
        popEmptyViewController()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateUserLocation : [CLLocation]) {
        UsersLocation.shared.getCityName(onSuccess: { [weak self] responce in
            let newController = ViewController(city: responce)
            UserSettings.shared.currentSettings.currentPlace = responce
            self?.navigationController?.pushViewController(newController, animated: false)
        }, onFailure: { (Error) in
            self.popEmptyViewController()
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeStatus status: CLAuthorizationStatus) {
        if status == .denied || status == .restricted {
            popEmptyViewController()
        }
    }
    
}

