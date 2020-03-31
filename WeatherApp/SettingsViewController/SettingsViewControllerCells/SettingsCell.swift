//
//  SettingsCell.swift
//  WeatherApp
//
//  Created by Marentilo on 24.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

class SettingsCell: UITableViewCell {
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    var settingsTitle : String? {
        get { return settingsLabel.text}
        set {settingsLabel.text = newValue
            iconView.image = UIImage(named: newValue!)
            setupSegmentedControll()
        }
    }
    
    var iconImage : UIImage? {
        get {return iconView.image}
        set {iconView.image = newValue}
    }
    
    private let iconView : UIImageView = {
        let imageView = UIImageView()
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return imageView
    } ()
    
    private let settingsLabel : UILabel = {
        let label = UILabel()
        label.text = "Temperature"
        label.font = UIFont.systemFont(ofSize: 24)
        return label
    } ()
    
    private let segmentedController : UISegmentedControl = {
        let controller = UISegmentedControl(items: ["--:--", "--:--"])
        controller.selectedSegmentIndex = 0
        return controller
    } ()

    func setupView () {
        
        
        for index in 0..<segmentedController.numberOfSegments {
            segmentedController.setWidth(contentView.bounds.width / 4, forSegmentAt: index)
        }
        
        segmentedController.addTarget(self, action: #selector(segmentControllerValueChanged(sender:)), for: .valueChanged)
        
        [
        iconView,
        settingsLabel,
        segmentedController
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        setupConstrains()
    }
    
    func setupSegmentedControll() {
        switch settingsLabel.text {
        case UserSettings.Constants.pressure:
            segmentedController.setTitle(Converter.Pressure.metric, forSegmentAt: 0)
            segmentedController.setTitle(Converter.Pressure.imperial, forSegmentAt: 1)
            segmentedController.selectedSegmentIndex = UserSettings.shared.pressureValue
        case UserSettings.Constants.temperature:
            segmentedController.setTitle(Converter.Temperature.metric, forSegmentAt: 0)
            segmentedController.setTitle(Converter.Temperature.imperial, forSegmentAt: 1)
            segmentedController.selectedSegmentIndex = UserSettings.shared.temperatureValue
        case UserSettings.Constants.wind:
            segmentedController.setTitle(Converter.WindSpeed.metric, forSegmentAt: 0)
            segmentedController.setTitle(Converter.WindSpeed.imperial, forSegmentAt: 1)
            segmentedController.selectedSegmentIndex = UserSettings.shared.windSpeedValue
        case UserSettings.Constants.timeformat:
            segmentedController.setTitle(Converter.TimeFormat.metric, forSegmentAt: 0)
            segmentedController.setTitle(Converter.TimeFormat.imperial, forSegmentAt: 1)
            segmentedController.selectedSegmentIndex = UserSettings.shared.timeValue
        default:
            break
        }
                
    }
    
    func setupConstrains() {
        let constrains = [
            
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.double * 2),
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double),
            iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.double * 2),
            
            settingsLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: Space.double),
            settingsLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            
            segmentedController.topAnchor.constraint(equalTo: contentView.topAnchor, constant:  Space.double * 2),
            segmentedController.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Space.double),
            segmentedController.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant:  -Space.double * 2),

        ]
        
        NSLayoutConstraint.activate(constrains)
    }
    
    // MARK : - Actions
    
    @objc func segmentControllerValueChanged(sender: UISegmentedControl) {
        
        let newValue = sender.selectedSegmentIndex
        switch settingsLabel.text {
        case UserSettings.Constants.pressure:
            UserSettings.shared.pressureValue = newValue
        case UserSettings.Constants.temperature:
            UserSettings.shared.temperatureValue = newValue
        case UserSettings.Constants.wind:
            UserSettings.shared.windSpeedValue = newValue
        case UserSettings.Constants.timeformat:
            UserSettings.shared.timeValue = newValue
        default:
            break
        }
    }
    
    

}
