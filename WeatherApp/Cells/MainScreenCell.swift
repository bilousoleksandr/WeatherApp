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
        set { temperatureLabel.text = "\(newValue ?? "0")°" }
    }
    
    var feelingTitle: String? {
        get { return feelingLikeLabel.text }
        set { feelingLikeLabel.text = "Feeling like \(newValue ?? "0")°" }
    }
    
    var windTitle: String? {
        get { return windLabel.text }
        set { windLabel.text = "\(newValue ?? "0")" }
    }
    
    var pressureTitle: String? {
        get { return pressureLabel.text }
        set { pressureLabel.text = "\(newValue ?? "0")" }
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
        imageView.image = UIImage(named: "wind")
        return imageView
    }()
    
    private let windLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "100 м/с"
        return label
    } ()
    
    private let pressureIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage(named: "pressure")
        return imageView
    }()
    
    private let pressureLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "1020 P/M"
        return label
    } ()
    
    private let humidityIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage(named: "humidity")
        return imageView
    }()
    
    private let humidityLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "80%"
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
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    }()
    
    private let temperatureLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 60)
        return label
    } ()
    
    private let feelingLikeLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 18)
        label.textAlignment = .center
        return label
    } ()
    
    // MARK: - Sunrise, Sunset and Visibility
    
    private let sunriseIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage(named: "sunrise")
        return imageView
    }()
    
    private let sunriseLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "08:12"
        return label
    } ()
    
    private let sunsetIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage(named: "sunset")
        return imageView
    }()
    
    private let sunsetLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "18:12"
        return label
    } ()
    
    private let windDirectionTitleIconView: UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage(named: "direction")
        return imageView
    }()
    
    private let windDirectionTitleLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 18)
        label.text = "300 M"
        return label
    } ()
    
    private let tmpView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Clouds background")
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        return view
    } ()
    
    private func setupView() {
        
        [
//            tmpView,
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
        
        temperatureLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.single),
        temperatureLabel.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: -Space.double*4),
        
        iconView.centerYAnchor.constraint(equalTo: temperatureLabel.centerYAnchor),
        iconView.leadingAnchor.constraint(equalTo: temperatureLabel.trailingAnchor, constant: Space.double),

            
        weatherDesctiptionLabel.topAnchor.constraint(equalTo: temperatureLabel.bottomAnchor, constant: Space.single),
        weatherDesctiptionLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

        feelingLikeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        feelingLikeLabel.topAnchor.constraint(equalTo: weatherDesctiptionLabel.bottomAnchor, constant: Space.single),
        
        sunriseIconView.topAnchor.constraint(equalTo: feelingLikeLabel.bottomAnchor, constant: Space.double),
        sunriseIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double),
        
        sunriseLabel.centerYAnchor.constraint(equalTo: sunriseIconView.centerYAnchor),
        sunriseLabel.leadingAnchor.constraint(equalTo: sunriseIconView.trailingAnchor, constant: Space.double),
        
        windIconView.topAnchor.constraint(equalTo: sunriseLabel.bottomAnchor, constant: Space.single),
        windIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double),
        
        windLabel.centerYAnchor.constraint(equalTo: windIconView.centerYAnchor),
        windLabel.leadingAnchor.constraint(equalTo: windIconView.trailingAnchor, constant: Space.double),
        
        humidityIconView.topAnchor.constraint(equalTo: windIconView.bottomAnchor, constant: Space.single),
        humidityIconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double),
        humidityIconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.double),
        
        humidityLabel.centerYAnchor.constraint(equalTo: humidityIconView.centerYAnchor),
        humidityLabel.leadingAnchor.constraint(equalTo: humidityIconView.trailingAnchor, constant: Space.double),
        
        sunsetIconView.topAnchor.constraint(equalTo: feelingLikeLabel.bottomAnchor, constant: Space.double),
        sunsetIconView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: Space.double * 3),
        
        sunsetLabel.centerYAnchor.constraint(equalTo: sunsetIconView.centerYAnchor),
        sunsetLabel.leadingAnchor.constraint(equalTo: sunsetIconView.trailingAnchor, constant: Space.double),
        
        windDirectionTitleIconView.topAnchor.constraint(equalTo: sunriseIconView.bottomAnchor, constant: Space.single),
        windDirectionTitleIconView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: Space.double * 3),
        
        windDirectionTitleLabel.centerYAnchor.constraint(equalTo: windDirectionTitleIconView.centerYAnchor),
        windDirectionTitleLabel.leadingAnchor.constraint(equalTo: windDirectionTitleIconView.trailingAnchor, constant: Space.double),
        
        pressureIconView.topAnchor.constraint(equalTo: windDirectionTitleIconView.bottomAnchor, constant: Space.single),
        pressureIconView.leadingAnchor.constraint(equalTo: contentView.centerXAnchor, constant: Space.double * 3),
        pressureIconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.double),
        
        pressureLabel.centerYAnchor.constraint(equalTo: pressureIconView.centerYAnchor),
        pressureLabel.leadingAnchor.constraint(equalTo: pressureIconView.trailingAnchor, constant: Space.double)

        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
}
