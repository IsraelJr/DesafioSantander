//
//  LoginInteractor.swift
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

protocol LoginBusinessLogic
{
    func doSomething(request: Login.UserAccount)
    func validateLogin(user: String, password: String) -> Bool
    func presentInfo(with: String)
    func saveData(button: UISwitch, user: UITextField)
    func loadDataUserDefault()
}

protocol LoginDataStore
{
  var userAccount: Login.UserAccount? { get }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore
{
    var presenter: LoginPresentationLogic?
    var worker = LoginWorker()
    var userAccount: Login.UserAccount?

    // MARK: Do something

    func doSomething(request: Login.UserAccount) {
        worker.doSomeWork()

        let response = Login.UserAccount()
        presenter?.presentSomething(response: response)
    }
    
    func validateLogin(user: String, password: String) -> Bool {
        
        if  (isValidEmail(emailUser: user) || isValidCPF(cpfUser: user))
            &&
            (isValidPassword(passwordUser: password) || password == "1234")
        {
            getDataUser(user: user, password: password)
            return true
        } else {
            presenter?.showCustomAlert(alertTo: "buttonLogin")
            return false
        }
    }
    
    func presentInfo(with: String){
        presenter?.showCustomAlert(alertTo: with)
    }
    
    func saveData(button: UISwitch, user: UITextField) {
        worker.saveUserDefault(button: button, user: user)
    }
    
    func loadDataUserDefault() {
         presenter?.dataInitial(dataSwitch: worker.loadUserDefaultBool(), dataUser: worker.loadUserDefault())
    }
    
    private func getDataUser(user: String, password: String) {
        let parm = ["user": user, "password": password]
        worker.validateLogin(parameters: parm, onComplete: { rc in
            self.userAccount = rc.userAccount
            self.presenter?.login(userData: self.userAccount!)
        })
    }
    
    
}
