//
//  SelectedLocationsCell.swift
//  WeatherApp
//
//  Created by Marentilo on 26.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit

class SelectedLocationsCell: UITableViewCell {

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
    
    private let textlabel : UILabel = {
        let label = UILabel()
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.text = "Selected"
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    } ()
    
    
    func setupView() {
        [
            textlabel
        ].forEach{
            $0.translatesAutoresizingMaskIntoConstraints = false
            contentView.addSubview($0)
        }
        
        setupConstrains()
    }
    
    func setupConstrains() {
        let constrains = [
            textlabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: Space.double),
            textlabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Space.double),
            textlabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Space.double)
        ]
        
        NSLayoutConstraint.activate(constrains)
    }
    
    

}
