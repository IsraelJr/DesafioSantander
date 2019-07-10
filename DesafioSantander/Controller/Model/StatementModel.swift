//
//  Launch.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 25/06/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import Foundation

struct StatementModel: Codable {
    let statementList: [StatementList]
//    let error: Error?
}

struct StatementList: Codable {
    let title: String
    let desc: String
    let date: String
    let value: Double
    
    var valueFormatted: String {
        return "R$ \(value)"
    }
    
    var dateFormatted: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: self.date) // replace Date String
        dateFormatter.dateFormat = "dd/MM/yyyy"
        return dateFormatter.string(from: date!)
    }
    
    
}
