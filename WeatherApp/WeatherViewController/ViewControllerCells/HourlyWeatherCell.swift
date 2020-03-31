//
//  HourlyWeatherCell.swift
//  WeatherApp
//
//  Created by Marentilo on 23.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

class HourlyWeatherCell: UICollectionViewCell {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    var dayText : String? {
        get {return dayLabel.text}
        set {dayLabel.text = newValue}
    }
    
    var timeText : String? {
        get {return timeLabel.text}
        set {timeLabel.text = newValue}
    }
    
    var tempText : String? {
        get {return tempLabel.text}
        set {tempLabel.text = newValue}
    }
    
    var iconImage : UIImage? {
        get {return iconView.image}
        set {iconView.image = newValue}
    }
    
    private let dayLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    } ()
    
    
    private let timeLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    } ()
    
    private let tempLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 22)
        label.text = "-:-"
        return label
    } ()
    
    private let iconView : UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage.WeatherConditions.defaultImage
        return imageView
    } ()
    
    func setupView () {
        [
          dayLabel,
          timeLabel,
          iconView,
          tempLabel
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        setConstraints()
    }
    
    func setConstraints () {
        
        let constraints = [
            dayLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.single),
            dayLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            timeLabel.topAnchor.constraint(equalTo: dayLabel.topAnchor, constant: Space.single),
            timeLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),

            iconView.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: 0),
            iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            tempLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: Space.single),
            tempLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            tempLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.single)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    
    
}
