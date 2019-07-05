//
//  UserModel.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 29/06/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import Foundation

struct UserModel: Codable {
    let userAccount: UserAccount
    let error: String
}

struct UserAccount: Codable {
    let user: String
    let password: String
}

