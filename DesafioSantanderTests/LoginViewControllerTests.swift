//
//  LoginViewControllerTests.swift
//  DesafioSantanderTests
//
//  Created by Israel Alves Santos Junior on 12/07/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import XCTest

@testable import DesafioSantander

class LoginViewControllerTests: XCTestCase {

    var loginViewController: LoginViewController!
    var loginInteractor: LoginInteractorSpy!
    var window: UIWindow!
    var button: UIButton = UIButton(type: .custom)
    
    class LoginInteractorSpy: LoginBusinessLogic {
        var loggedIn: Bool = false
        
        func validateLogin(user: String, password: String) -> Bool {
            loggedIn = true
            return loggedIn
        }
        
        func doSomething(request: Login.UserAccount) {
            //nil
        }
        
        func presentInfo(with: String) {
            //nil
        }
        
        func saveData(button: UISwitch, user: UITextField) {
            //nil
        }
        
        func loadDataUserDefault() {
            //nil
        }
        
    }
    
    override func setUp() {
        window = UIWindow()
        loginViewController = LoginViewController()
        loginInteractor = LoginInteractorSpy()
        loginViewController.interactor = loginInteractor
        //button = loginViewController.buttonLogin
        
        window.addSubview(loginViewController.view)
        RunLoop.current.run(until: Date())
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        print("Test login view controller")
        button.restorationIdentifier = "buttonLogin"
        
        self.loginViewController.actionButtons(button)
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
