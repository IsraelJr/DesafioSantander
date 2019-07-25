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
import Alamofire

enum StatementErrorWorker {
    case noResponse
    case invalidJson
}

typealias responseStatement = (_ response: StatementModels) -> ()

class StatementWorker {
    
    let url = "https://bank-app-test.herokuapp.com/api/statements/1"
    
    func loadStatements(onComplete: @escaping (responseStatement), onError: @escaping (StatementErrorWorker) -> Void) {
        
        Alamofire.request(url).responseJSON(completionHandler: { response in
            
            switch response.result {
            case .success(_):
                do {
                    let extractResponse = try JSONDecoder().decode(StatementModels.self, from: response.data!)
                    onComplete(extractResponse)
                } catch  {
                    onError(.invalidJson)
                }
            case .failure:
                onError(.noResponse)
            }
            
        })
    }
    
    
}


