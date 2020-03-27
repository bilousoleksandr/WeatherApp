//
//  AboutAppCell.swift
//  WeatherApp
//
//  Created by Marentilo on 24.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

class AboutAppCell: UITableViewCell {
     
     var aboutAppTitle : String? {
         get { return aboutAppLabel.text}
         set { aboutAppLabel.text = newValue}
     }
    
    var detailsTitle : String? {
        get { return detailsLabel.text}
        set { detailsLabel.text = newValue}
    }
     
     private let aboutAppLabel : UILabel = {
         let label = UILabel()
         label.font = UIFont.systemFont(ofSize: 24)
         label.setContentCompressionResistancePriority(.required, for: .horizontal)
         label.setContentHuggingPriority(.required, for: .horizontal)
         return label
     } ()
    
    private let detailsLabel : UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 22)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 8
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.textAlignment = .center
        label.text = """
        Weather app can get 5 days/3 hours forecast for city.
        \nIcons made by Good Ware and Freepik from www.flaticon.com
        \nDesign by Alexander Bilous
        """
        return label
    }()
     
     
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
            aboutAppLabel,
            detailsLabel
         ].forEach {
             $0.translatesAutoresizingMaskIntoConstraints = false
             contentView.addSubview($0)
         }
         
         setupConstrains()
     }
     
     func setupConstrains() {
         let constrains = [
             aboutAppLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.double),
             aboutAppLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
             
             detailsLabel.topAnchor.constraint(equalTo: aboutAppLabel.bottomAnchor, constant: Space.double),
             detailsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double),
             detailsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -Space.double),
             detailsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.double * 5)
         ]
         
         NSLayoutConstraint.activate(constrains)
     }

}
