//
//  StatementModels.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 05/07/19.
//  Copyright (c) 2019 Israel Alves Santos Junior. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import Foundation

struct StatementModels: Codable {
    let statementList: [StatementList]
    let error: Error?
    
    struct StatementList: Codable {
        let title: String
        let desc: String
        let date: String
        var value: Double
        
        var valueFormatted: String {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .currency
            numberFormatter.locale = Locale(identifier: "pt_br")
            return numberFormatter.string(from: NSNumber(value: self.value))!            
        }
        
        var dateFormatted: String {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: self.date) // replace Date String
            dateFormatter.dateFormat = "dd/MM/yyyy"
            return dateFormatter.string(from: date!)
        }
    }
    struct Error: Codable {
        var message: String?
    }
    
}
