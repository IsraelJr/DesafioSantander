//
//  ValidationUtils.swift
//  DesafioSantander
//
//  Created by Israel Alves Santos Junior on 26/06/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import Foundation

let cpfRegex =
    "[0-9]{11}$"

let emailRegEx =
    "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"

let characterPasswordRegEx = "^(?=.*?[A-Z])(?=.*?[a-z[0-9]])(?=.*?[#?!@$%^&*-.])[[A-Za-z[0-9]]#?!@$%^&*-.]{0,}$"



func validationEmail(emailUser: String) -> Bool {
    
    let email = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return email.evaluate(with: emailUser)
}


func validationPassword(passwordUser: String) -> Bool {
    
    let password = NSPredicate(format:"SELF MATCHES %@", characterPasswordRegEx)
    return password.evaluate(with: passwordUser)
}
