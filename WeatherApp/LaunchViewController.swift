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
    
    func setupView() {
        view.backgroundColor = UIColor.white
        UsersLocation.shared.delegate = self
        UsersLocation.shared.locationManager.requestAlwaysAuthorization()
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

