//
//  REST.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 28/06/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import Foundation

class REST {
    
    private static let basePath = "https://bank-app-test.herokuapp.com/api/statements/1"
    
    private static let configuration: URLSessionConfiguration = {
    
        let config = URLSessionConfiguration.default
        config.httpAdditionalHeaders = ["Content-Type": "application/json"]
        config.timeoutIntervalForRequest = 5.0
        config.httpMaximumConnectionsPerHost = 2
        
        return config
        
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    class func loadStatements(){
        
        guard let url = URL(string: basePath) else {return}
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error == nil {
                guard let resultResponse = response as? HTTPURLResponse else {return}
                
                if resultResponse.statusCode == 200 {
                    guard let data = data else {return}
//                    do {
//                        let statements = try JSONDecoder().decode([Statements].self, from: data)
//                        for extrato in statements { 
//                            print("Extrato: \(extrato.statementList[0].desc)")
//                            print("Erro do JSON 1: \(error?.localizedDescription)")
//                        }
//                    } catch {
//                        print("Erro do JSON 2: \(error.localizedDescription)")
//                    }
                    
                } else {
                    print("Algum erro do servidor")
                }
            } else {
                print("O erro é: \(error!)")
            }
            
        }
        dataTask.resume()
    }
    
}
