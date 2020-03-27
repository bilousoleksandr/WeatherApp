//
//  UserLocationDisabledCell.swift
//  WeatherApp
//
//  Created by Marentilo on 26.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

class UserLocationDisabledCell: UITableViewCell {
    
    
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
    
    private let iconView: UIImageView = {
        let imageView = UIImageView()
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.image = UIImage(named: "satellite")
        return imageView
    }()
    
    private let titleLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 24)
        label.text = "Geolocation is turned off"
        return label
    } ()
    
    private let subtitleLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 20)
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.numberOfLines = 2
        label.text = "Weather app can't show current location weather without geolocation"
        return label
    } ()
    
    private let allowLocationButton : UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Turn on location", for: .normal)
        button.backgroundColor = UIColor.carrot
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.contentEdgeInsets = UIEdgeInsets(top: Space.single, left: Space.double, bottom: Space.single, right: Space.double)
        button.titleLabel?.textColor = UIColor.white
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        return button
    } ()
    
    
    func setupView() {
        allowLocationButton.addTarget(self, action: #selector(allowLocationButtonPressed(sender:)), for: .touchUpInside)
        
        [
            iconView,
            titleLabel,
            subtitleLabel,
            allowLocationButton
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        setupConstrains()
    }
    
    func setupConstrains() {
        let constrains = [
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.double * 3),
            iconView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: iconView.bottomAnchor, constant: Space.double),
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: Space.double),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant:  Space.double * 3),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -Space.double * 3),
            
            allowLocationButton.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: Space.double * 2),
            allowLocationButton.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            allowLocationButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.double * 3)
            
        ]
        
        NSLayoutConstraint.activate(constrains)
    }
    
    // MARK: - Actions
    
    @objc func allowLocationButtonPressed(sender: UIButton) {
        if let url = URL.init(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

}
