//
//  ChangeLocationCell.swift
//  WeatherApp
//
//  Created by Marentilo on 26.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

class ChangeLocationCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    
    private let iconView : UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage.Navigation.placeholder
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        imageView.setContentCompressionResistancePriority(.required, for: .horizontal)
        return imageView
    } ()
    
    private let textlabel : UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.text = "Specify location"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.white
        return label
    } ()
    
    // MARK: - Background image
    
    var background : UIImage? {
        get { return tmpView.image}
        set { tmpView.image = newValue}
    }
    
    private let tmpView : UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "Clear background")
        view.setContentHuggingPriority(.required, for: .horizontal)
        view.setContentCompressionResistancePriority(.required, for: .horizontal)
        return view
    } ()
    
    
    func setupView() {
        self.backgroundView = tmpView
        
        [
            iconView,
            textlabel
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        setupConstrains()
    }
    
    func setupConstrains() {
        let constrains = [
            iconView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double),
            iconView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.single),
            iconView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.single),
            
            textlabel.leadingAnchor.constraint(equalTo: iconView.trailingAnchor, constant: Space.double),
            textlabel.centerYAnchor.constraint(equalTo: iconView.centerYAnchor)
        ]
        
        NSLayoutConstraint.activate(constrains)
        
    }

}
