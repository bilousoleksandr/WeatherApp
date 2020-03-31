//
//  StaticSettingsCell.swift
//  WeatherApp
//
//  Created by Marentilo on 21.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

class StaticSettingsCell: UITableViewCell {
    
    
    var dayOfMonthTitle : String? {
        get { return dayOfMonthLabel.text}
        set { dayOfMonthLabel.text = newValue}
    }
    
    var dayOfWeekTitle : String? {
        get { return dayOfWeekLabel.text}
        set { dayOfWeekLabel.text = newValue}
    }
    
    var maxTempTitle : String? {
        get { return maxTempLabel.text}
        set { maxTempLabel.text = newValue }
    }
    
    var minTempTitle : String? {
        get { return minTempLabel.text}
        set { minTempLabel.text = newValue }
    }
    
    var iconImage : UIImage? {
        get { return iconView.image }
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

    private let dayOfMonthLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 18)
        return label
    } ()
    
    private let dayOfWeekLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    } ()
    
    private let minTempLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 22)
        label.textColor = UIColor.lightGray
        label.text = "-:-"
        return label
    } ()
    
    private let maxTempLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.text = "-:-"
        return label
    } ()
    
    private let iconView : UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage(named: "default")
        return imageView
    } ()
    
    
    private func setupView() {
        [
            iconView,
            dayOfWeekLabel,
            dayOfMonthLabel,
            minTempLabel,
            maxTempLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        
        let constraints = [
            dayOfMonthLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.single),
            dayOfMonthLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double),
            
            dayOfWeekLabel.topAnchor.constraint(equalTo: dayOfMonthLabel.bottomAnchor, constant: Space.single),
            dayOfWeekLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double),
            dayOfWeekLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.single),
            
            minTempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            minTempLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Space.double),
            
            maxTempLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            maxTempLabel.trailingAnchor.constraint(equalTo: minTempLabel.leadingAnchor, constant: -Space.double),
            
            iconView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor, constant: 0),
            iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

}
