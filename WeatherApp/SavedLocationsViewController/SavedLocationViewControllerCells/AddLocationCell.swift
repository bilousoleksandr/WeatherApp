//
//  AddLocationCell.swift
//  WeatherApp
//
//  Created by Marentilo on 25.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

class AddLocationCell: UITableViewCell {
    
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
    
    private let addLabel : UILabel = {
        let label = UILabel()
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.font = UIFont.systemFont(ofSize: 20)
        label.text = "New location"
        return label
    } ()
    
    private let iconView : UIImageView = {
        let imageView = UIImageView()
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        imageView.image = UIImage.Navigation.add
        return imageView
    } ()
    
    func setupView() {
        [
            addLabel,
            iconView
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        setupConstrains()
    }
    
    func setupConstrains() {
        let constrains = [
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double),
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.double),
            iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.single),
            
            addLabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor),
            addLabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: Space.double)
        ]
        
        NSLayoutConstraint.activate(constrains)
    }

}
