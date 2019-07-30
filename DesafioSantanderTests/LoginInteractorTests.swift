//
//  LoginInteractorTests.swift
//  DesafioSantanderTests
//
//  Created by Israel Alves Santos Junior on 12/07/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

//import XCTest
//@testable import DesafioSantander
//
//class LoginInteractorTests: XCTestCase {
//
//    let loginInte = LoginInteractor()
//
//    func test_validateLogin() {
//        XCTAssertTrue(loginInte.validateLogin(user: "a@gmail.com", password: "A!1"))
//        XCTAssertFalse(loginInte.validateLogin(user: "agmail.com", password: "A!1"))
//        XCTAssertFalse(loginInte.validateLogin(user: "a@gmail.com", password: "A!a"))
//        XCTAssertFalse(loginInte.validateLogin(user: "a@gmail.com", password: "A!"))
//    }
//
//    func test_loadDataUserDefault() {
//        loginInte.loadDataUserDefault()
//    }
//
//    func test_presentInfo() {
//        loginInte.presentInfo(with: "buttonInfo")
//    }
//
//    func test_doSomething() {
//        let lua = Login.UserAccount(userId: 1, name: "José", agency: "0642", bankAccount: "010234625", balance: 10.0)
//        loginInte.doSomething(request: lua)
//    }
//
//}


import Nimble
import Quick

@testable import DesafioSantander

class LoginInteractorTests: QuickSpec {

    var loginInteractor: LoginInteractor!
    var loginPresenter: LoginPresenterSpy!
    
    class LoginPresenterSpy: LoginPresentationLogic {
        
        var testLogin   = false
        var alert       = false
        
        func presentSomething(response: Login.UserAccount) {
            print("function presentSomething")
        }
        
        func dataInitial(dataSwitch: Bool, dataUser: String) {
            print("function dataInitial")
        }
        
        func showCustomAlert(alertTo: String) {
            alert = true
            print("function showCustomAlert")
        }
        
        func login(userData: Login.UserAccount) {
            testLogin = true
            print("function login")
        }
        
        
    }
    
    fileprivate func setup() {
        
        loginInteractor = LoginInteractor()
        loginPresenter  = LoginPresenterSpy()
        loginInteractor.presenter = loginPresenter
        
    }
    
    override func spec() {
        
        describe("Test data login") {
            
            beforeEach {
                self.setup()
            }
            
            it("Data user valid") {
                
                _ = self.loginInteractor.validateLogin(user: "a@gmail.com", password: "A!1")
                expect(self.loginPresenter.alert).toNot(beTrue())
                
                _ = self.loginInteractor.validateLogin(user: "a@gmail.com", password: "Aas!afD2sd4f@")
                expect(self.loginPresenter.alert).toNot(beTrue())
                
                _ = self.loginInteractor.validateLogin(user: "12345678912", password: "A!1")
                expect(self.loginPresenter.alert).toNot(beTrue())
                
                _ = self.loginInteractor.validateLogin(user: "123.456.789-12", password: "A!1")
                expect(self.loginPresenter.alert).toNot(beTrue())
                
            }
            
            it("Data user invalid") {

                _ = self.loginInteractor.validateLogin(user: "a@gmail.com", password: "A!")
                expect(self.loginPresenter.alert).to(beTrue())

                _ = self.loginInteractor.validateLogin(user: "agmail.com", password: "A!1")
                expect(self.loginPresenter.alert).to(beTrue())

                _ = self.loginInteractor.validateLogin(user: "agmail.com", password: "A!dadaada@E")
                expect(self.loginPresenter.alert).to(beTrue())

                _ = self.loginInteractor.validateLogin(user: "a@gmail.com", password: "A!dada!")
                expect(self.loginPresenter.alert).to(beTrue())

            }
        }
    }
    
}
