//
//  REST.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 28/06/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import Foundation

enum StatementError {
    case url
    case taskError(error: Error)
    case noResponse
    case noData
    case responseStatusCode(code: Int)
    case invalidJson
}


class REST {
    
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
    
    class func loadStatements (onComplete: @escaping (StatementModel) -> Void, onError: @escaping (StatementError) -> Void) {
        
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
                        print("Extrato do dia: \(statementModel.statementList[1].value)")
                        onComplete(statementModel)
                        print("depois do onComplete")
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
    
    
    class func validateLogin(userModel: UserModel, onComplete: @escaping (Bool) -> Void){
        guard let url = URL(string: basePathPost) else {
         onComplete(false)
            print("Erro nessa URL de Request!!!")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        guard let json = try? JSONEncoder().encode(userModel) else {
            onComplete(false)
            return
        }
        
        request.httpBody = json
        let dataTask = session.dataTask(with: url) { (dataJson, responseJson, error) in
            if error == nil {
                guard let response = responseJson as? HTTPURLResponse, response.statusCode == 200, let _ = dataJson else {
                    onComplete(false)
                    return
                }
                onComplete(true)
            } else {
                onComplete(false)
            }
        }
        dataTask.resume()
    }
    
    
}
