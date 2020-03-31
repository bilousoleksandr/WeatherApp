//
//  MainCell.swift
//  WeatherApp
//
//  Created by Marentilo on 24.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

class MainLocationCell: UITableViewCell {
    
    
    var locationTitle : String? {
        get { return locationLabel.text}
        set { locationLabel.text = newValue}
    }
    
    var infoTitle : String? {
        get { return infoLabel.text}
        set {
            infoLabel.text = newValue
            imageView?.image = UIImage(named: newValue!)
        }
    }
    
    private let infoLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    } ()
    
    private let locationLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        return label
    } ()
    
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
    
    func setupView() {
        
        [
            infoLabel,
            locationLabel
        ].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        setupConstrains()
    }
    
    func setupConstrains() {
        let constrains = [
            infoLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.double),
            infoLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            locationLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: Space.double),
            locationLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            locationLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.double)
        ]
        
        NSLayoutConstraint.activate(constrains)
    }

}
