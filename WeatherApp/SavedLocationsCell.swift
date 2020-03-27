//
//  SavedLocationsCell.swift
//  WeatherApp
//
//  Created by Marentilo on 25.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

class SavedLocationsCell: UITableViewCell {
    
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
    
    var tempTitle : String?  {
        get { return temperatureLabel.text}
        set {temperatureLabel.text = "\(newValue ?? "-:-")°"}
    }
    
    var cityTitle : String?  {
        get { return cityLabel.text}
        set {cityLabel.text = newValue}
    }
    
    var timeTitle : String?  {
        get { return timeLabel.text}
        set {timeLabel.text = newValue}
    }
    
    var iconImage : UIImage? {
        get { return iconView.image}
        set { iconView.image = newValue}
    }
    
    
    // MARK: Temperature, icon
    
    private let temperatureLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.text = "-:-"
        return label
    } ()
    
    private let iconView : UIImageView = {
        let imageView = UIImageView()
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.image = UIImage(named: "sunset")
        return imageView
    } ()
    
    // MARK: - City, Current time
    
    private let cityLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 26)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.text = "-:-"
        return label
    } ()
    
    private let timeLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 20)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.text = "-:-"
        return label
    } ()
    
    func setupView() {
        
        [
            timeLabel,
            cityLabel,
            iconView,
            temperatureLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        setupConstrains()
    }
    
    func setupConstrains () {
        let constrains = [
            timeLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.double),
            timeLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double),
            
            cityLabel.topAnchor.constraint(equalTo: timeLabel.bottomAnchor, constant: Space.double),
            cityLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double),
            cityLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.double),
            
            iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor, constant: 0),
            iconView.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor, constant: 0),
            
            temperatureLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Space.double),
            temperatureLabel.centerYAnchor.constraint(equalTo: cityLabel.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constrains)
    }

}
