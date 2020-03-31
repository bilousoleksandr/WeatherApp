//
//  MainScreenCell.swift
//  WeatherApp
//
//  Created by Marentilo on 22.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

class MainScreenCell: UITableViewCell {
    
    var weatherDescriptionTitle: String? {
        get { return weatherDesctiptionLabel.text }
        set { weatherDesctiptionLabel.text = newValue }
    }
    
    var temperatureTitle: String? {
        get { return temperatureLabel.text }
        set { temperatureLabel.text = newValue  }
    }
    
    var feelingTitle: String? {
        get { return feelingLikeLabel.text }
        set { feelingLikeLabel.text = newValue }
    }
    
    var windTitle: String? {
        get { return windLabel.text }
        set { windLabel.text = newValue }
    }
    
    var pressureTitle: String? {
        get { return pressureLabel.text }
        set { pressureLabel.text = newValue }
    }
    
    var humidityTitle: String? {
        get { return humidityLabel.text }
        set { humidityLabel.text = "\(newValue ?? "0") %" }
    }
    
    var sunsetTitle: String? {
        get { return sunsetLabel.text }
        set { sunsetLabel.text = newValue }
    }
    
    var sunriseTitle: String? {
        get { return sunriseLabel.text }
        set { sunriseLabel.text = newValue }
    }
    
    var windDirectionTitle: String? {
        get { return windDirectionTitleLabel.text }
        set { windDirectionTitleLabel.text = newValue }
    }
    
    var iconImage : UIImage? {
        get {return iconView.image }
        set {iconView.image = newValue}
    }
    
    var backgroundImage : UIImage? {
        get { return tmpView.image}
        set { tmpView.image = newValue}
    }

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
    
    
    // MARK: - Wind, Pressure and Humidity
    
    private let windIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage.WeatherConditions.wind
        return imageView
    }()
    
    private let windLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "-:-"
        label.textColor = UIColor.white
        return label
    } ()
    
    private let pressureIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage.WeatherConditions.pressure
        return imageView
    }()
    
    private let pressureLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "-:-"
        label.textColor = UIColor.white
        return label
    } ()
    
    private let humidityIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage.WeatherConditions.humidity
        return imageView
    }()
    
    private let humidityLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "-:-"
        label.textColor = UIColor.white
        return label
    } ()
    
    // MARK: - Main Temperature Views
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        return imageView
    }()
    
    private let weatherDesctiptionLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    }()
    
    private let temperatureLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 60)
        label.textColor = UIColor.white
        return label
    } ()
    
    private let feelingLikeLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = UIColor.white
        return label
    } ()
    
    // MARK: - Sunrise, Sunset and Visibility
    
    private let sunriseIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage.WeatherConditions.sunrise
        return imageView
    }()
    
    private let sunriseLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "-:-"
        label.textColor = UIColor.white
        return label
    } ()
    
    private let sunsetIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage.WeatherConditions.sunset
        return imageView
    }()
    
    private let sunsetLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "-:-"
        label.textColor = UIColor.white
        return label
    } ()
    
    private let windDirectionTitleIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage.WeatherConditions.direction
        return imageView
    }()
    
    private let windDirectionTitleLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.text = "-:-"
        label.textColor = UIColor.white
        return label
    } ()
    
    var background : UIImage? {
        get { return tmpView.image}
        set { tmpView.image = newValue}
    }
    
    private let tmpView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage.backgroundImage("Clear")
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        return view
    } ()
    
    private func setupView() {
        self.backgroundView = tmpView
        
        [
            iconView,
            temperatureLabel,
            weatherDesctiptionLabel,
            feelingLikeLabel,
            windIconView,
            pressureIconView,
            humidityIconView,
            sunriseLabel,
            sunsetLabel,
            windDirectionTitleLabel,
            windDirectionTitleIconView,
            sunriseIconView,
            sunsetIconView,
            windLabel,
            humidityLabel,
            pressureLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        contentView.layoutMargins = UIEdgeInsets(top: Space.double,
                                                 left: Space.double,
                                                 bottom: Space.double,
                                                 right: Space.double)
        let constraints = [
        
        temperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: (UIApplication.shared.statusBarFrame.height + (UIApplication.shared.windows[0].rootViewController?.navigationController?.navigationBar.bounds.height ?? 0) + Space.double * 4)),
        temperatureLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -Space.double*4),
        
        iconView.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
        iconView.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: Space.double),

            
        weatherDesctiptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: Space.single),
        weatherDesctiptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

        feelingLikeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        feelingLikeLabel.topAnchor.constraint(equalTo: weatherDesctiptionLabel.bottomAnchor, constant: Space.single),
        
        sunriseIconView.topAnchor.constraint(equalTo: feelingLikeLabel.bottomAnchor, constant: Space.double),
        sunriseIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double * 2),
        
        sunriseLabel.centerYAnchor.constraint(equalTo: sunriseIconView.centerYAnchor),
        sunriseLabel.leadingAnchor.constraint(equalTo: sunriseIconView.trailingAnchor, constant: Space.double),
        
        windIconView.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: Space.single),
        windIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double * 2),
        
        windLabel.centerYAnchor.constraint(equalTo: windIconView.centerYAnchor),
        windLabel.leadingAnchor.constraint(equalTo: windIconView.trailingAnchor, constant: Space.double),
        
        humidityIconView.topAnchor.constraint(equalTo: windIconView.bottomAnchor, constant: Space.single),
        humidityIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double * 2),
        humidityIconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.double),
        
        humidityLabel.centerYAnchor.constraint(equalTo: humidityIconView.centerYAnchor),
        humidityLabel.leadingAnchor.constraint(equalTo: humidityIconView.trailingAnchor, constant: Space.double),
        
        sunsetIconView.topAnchor.constraint(equalTo: feelingLikeLabel.bottomAnchor, constant: Space.double),
        sunsetIconView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: Space.double * 2),
        
        sunsetLabel.centerYAnchor.constraint(equalTo: sunsetIconView.centerYAnchor),
        sunsetLabel.leadingAnchor.constraint(equalTo: sunsetIconView.trailingAnchor, constant: Space.double),
        
        windDirectionTitleIconView.topAnchor.constraint(equalTo: sunriseIconView.bottomAnchor, constant: Space.single),
        windDirectionTitleIconView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: Space.double * 2),
        
        windDirectionTitleLabel.centerYAnchor.constraint(equalTo: windDirectionTitleIconView.centerYAnchor),
        windDirectionTitleLabel.leadingAnchor.constraint(equalTo: windDirectionTitleIconView.trailingAnchor, constant: Space.double),
        
        pressureIconView.topAnchor.constraint(equalTo: windDirectionTitleIconView.bottomAnchor, constant: Space.single),
        pressureIconView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: Space.double * 2),
        pressureIconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.double),
        
        pressureLabel.centerYAnchor.constraint(equalTo: pressureIconView.centerYAnchor),
        pressureLabel.leadingAnchor.constraint(equalTo: pressureIconView.trailingAnchor, constant: Space.double),

        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
