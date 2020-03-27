//
//  Section.swift
//  WeatherApp
//
//  Created by Marentilo on 25.03.2020.
//  Copyright © 2020 Marentilo. All rights reserved.
//

import UIKit


class Section {

    let name : String
    var items : [String]
        
    init(name : String, items : [String]) {
        self.name = name
        self.items = items
    }
}
