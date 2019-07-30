//
//  LoginViewControllerTests.swift
//  DesafioSantanderTests
//
//  Created by Israel Alves Santos Junior on 12/07/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import Nimble
import Quick

@testable import DesafioSantander

class LoginViewControllerTests: QuickSpec {
    
    var loginViewController: LoginViewController!
    var loginInteractor: LoginInteractorSpy!
    var window: UIWindow!
    
    class LoginInteractorSpy: LoginBusinessLogic {
        
        var loggedIn    = false
        var info        = false
        
        func doSomething(request: Login.UserAccount) {
            print("function doSomething")
        }
        
        func validateLogin(user: String, password: String) -> Bool {
            loggedIn = true
            print("function validateLogin:",loggedIn)
            return loggedIn
        }
        
        func presentInfo(with: String) {
            info = true
            print("function presentInfo:",info)
        }
        
        func saveData(button: UISwitch, user: UITextField) {
            print("function saveData")
        }
        
        func loadDataUserDefault() {
            print("function loadDataUserDefault")
        }
        
    }
    
    fileprivate func setup() {

        window = UIWindow()
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        loginViewController = (storyboard.instantiateInitialViewController() as! LoginViewController)
        
        loginInteractor = LoginInteractorSpy()
        loginViewController.interactor = loginInteractor
        
        window.addSubview(loginViewController.view)
        RunLoop.current.run(until: Date())

    }
    
    override func spec() {
        
        describe("Test button view controller login") {
            
            beforeEach {
                self.setup()
            }
            
            it("Pressed info button to call actionButton") {
                self.loginViewController.buttonLogin.restorationIdentifier = "buttonInfo";
                self.loginViewController.actionButtons(self.loginViewController.buttonLogin)
                expect(self.loginInteractor.info).to(beTrue())
            }
            
            it("Pressed login button to call actionButton") {
                self.loginViewController.buttonLogin.restorationIdentifier = "buttonLogin";
                self.loginViewController.actionButtons(self.loginViewController.buttonLogin)
                expect(self.loginInteractor.loggedIn).to(beTrue())
            }
            
            it("Call actionButton with value unexpected") {
                self.loginViewController.buttonLogin.restorationIdentifier = "xXx";
                self.loginViewController.actionButtons(self.loginViewController.buttonLogin)
                expect(self.loginInteractor.info).to(beTrue())
            }
            
        }
        
    }
    
}
