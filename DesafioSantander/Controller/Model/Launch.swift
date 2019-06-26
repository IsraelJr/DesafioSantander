//
//  Launch.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 25/06/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import Foundation

struct Launch: Codable {
    
    let title: String
    let desc: String
    let date: String
    let value: Double
    
    var valueFormatted: String {
        return "R$ \(value)"
    }
    init(_ title: String, _ desc: String, _ date: String, _ value: Double) {
        self.title = title
        self.desc = desc
        self.date = date
        self.value = value
    }
    
    
}
