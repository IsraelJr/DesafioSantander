//
//  StatementWorker.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 05/07/19.
//  Copyright (c) 2019 Israel Alves Santos Junior. All rights reserved.
//
//  This file was generated by the Clean Swift Xcode Templates so
//  you can apply clean architecture to your iOS and Mac projects,
//  see http://clean-swift.com
//

import UIKit

enum StatementErrorWorker {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJson
}


class StatementWorker {
    
    func doSomeWork() {}
    
    private static let basePathGet = "https://bank-app-test.herokuapp.com/api/statements/1"
    private static let basePathPost = "https://bank-app-test.herokuapp.com/api/login"
    
    private static let configuration: URLSessionConfiguration = {
    
    let config = URLSessionConfiguration.default
    config.httpAdditionalHeaders = ["Content-Type": "application/json"]
    config.timeoutIntervalForRequest = 5.0
    config.httpMaximumConnectionsPerHost = 2
    
    return config
    
    }()
    
    private static let session = URLSession(configuration: configuration)
    
    class func loadStatements (onComplete: @escaping (StatementModel) -> Void, onError: @escaping (StatementErrorWorker) -> Void) {
        
        guard let url = URL(string: basePathGet) else {
            onError(.url)
            print("Erro nessa URL!!!")
            return
        }
        
        let dataTask = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
            
            if error == nil {
                guard let resultResponse = response as? HTTPURLResponse else {
                    onError(.noResponse)
                    print("deu ruim 1")
                    return
                }
                
                if resultResponse.statusCode == 200 {
                    guard let data = data else {
                        print("deu ruim 2")
                        return
                    }
                    do {
                        let statementModel = try JSONDecoder().decode(StatementModel.self, from: data)
                        print("Extrato: \(statementModel.statementList[1].value)")
                        onComplete(statementModel)
                    } catch {
                        print("Erro do JSON 2: \(error.localizedDescription)")
                        onError(.invalidJson)
                    }
                    
                } else {
                    print("Algum erro do servidor")
                    onError(.responseStatusCode(code: resultResponse.statusCode))
                }
            } else {
                print("O erro é esse aqui: \(error!)")
                onError(.taskError(error: error! as NSError))
            }
            
        }
        print("deu ruim 3")
        dataTask.resume()
    }
    
    
    
    
}

