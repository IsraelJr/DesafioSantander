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
    func doSomething(request: Login.Something.Request)
    func validateLogin(user: String, password: String)
    func presentInfo(with: String)
    func saveData(button: UISwitch, user: UITextField, password: UITextField)
    func loadDataUserDefault()
}

protocol LoginDataStore
{
  //var name: String { get set }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore
{
    var presenter: LoginPresentationLogic?
    var worker = LoginWorker()
    //var name: String = ""

    // MARK: Do something

    func doSomething(request: Login.Something.Request)
    {
    worker.doSomeWork()

    let response = Login.Something.Response()
    presenter?.presentSomething(response: response)
    }
    
    func validateLogin(user: String, password: String) {
        
        if  (isValidEmail(emailUser: user) || isValidCPF(cpfUser: user))
            &&
            (isValidPassword(passwordUser: password) || password == "1234")
        {
            presenter?.login(userData: Login.Something.ViewModel(user: user, password: password))
        } else {
            presenter?.showCustomAlert(alertTo: "buttonLogin")
        }
    }
    
    func presentInfo(with: String){
        presenter?.showCustomAlert(alertTo: with)
    }
    
    func saveData(button: UISwitch, user: UITextField, password: UITextField) {
        worker.saveUserDefault(button: button, user: user)
    }
    
    func loadDataUserDefault() {
         presenter?.dataInitial(dataSwitch: worker.loadUserDefaultBool(), dataUser: worker.loadUserDefault())
    }
    
}