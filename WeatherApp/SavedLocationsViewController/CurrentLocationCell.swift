//
//  CurrentLocationCell.swift
//  WeatherApp
//
//  Created by Marentilo on 26.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

class CurrentLocationCell: UITableViewCell {
    
    
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

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var cityTitle : String? {
        get {return currentCityLabel.text }
        set {currentCityLabel.text = newValue }
    }
    
    var temperatureTitle : String? {
        get { return temperatureLabel.text}
        set { temperatureLabel.text = "\(newValue ?? "0")°"}
    }
    
    var iconImage : UIImage? {
        get { return iconView.image }
        set { iconView.image = newValue}
    }
    
    
    private let currentLocationLabel : UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "Current location"
        return label
    } ()
    
    private let currentCityLabel : UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.text = "Current city"
        return label
    } ()
    
    private let temperatureLabel : UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.text = "-:-"
        return label
    } ()
    
    private let iconView : UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage(named: "Clear")
        return imageView
    } ()
    
    func setupView() {
        [
            currentLocationLabel,
            currentCityLabel,
            temperatureLabel,
            iconView
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        setupConstrains()
    }
    
    func setupConstrains() {
        let constrains = [
            currentLocationLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.double),
            currentLocationLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double),
            
            currentCityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double),
            currentCityLabel.topAnchor.constraint(equalTo: currentLocationLabel.bottomAnchor, constant: Space.double),
            currentCityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.double * 2),
            
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Space.double),
            temperatureLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constrains)
    }
}
