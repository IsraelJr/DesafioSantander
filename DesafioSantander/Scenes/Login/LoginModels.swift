//
//  LoginModels.swift
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

enum Login
{
  // MARK: Use cases
  
  enum Something
  {
    struct Request: Codable {
        let userAccount: UserAccount
    }
    struct Response {
    }
    struct ViewModel: Codable {
        let user: String
        let password: String
    }
  }
}

//struct LoginModels: Codable {
//    let userAccount: UserAccount
//    let error: Error
//}
//
//struct UserAccount: Codable {
//    let user: String
//    let password: String
//}
//
//struct Error: Codable {
//    var message: String?
//}

