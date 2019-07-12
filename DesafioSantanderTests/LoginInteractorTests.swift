//
//  LoginInteractorTests.swift
//  DesafioSantanderTests
//
//  Created by Israel Alves Santos Junior on 12/07/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import XCTest
@testable import DesafioSantander

class LoginInteractorTests: XCTestCase {

    let loginInte = LoginInteractor()
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_validateLogin() {
        loginInte.validateLogin(user: "1", password: "1")
    }
    
    func test_loadDataUserDefault() {
        loginInte.loadDataUserDefault()
    }
    
    func test_presentInfo() {
        loginInte.presentInfo(with: "buttonInfo")
    }
    
    func test_doSomething() {
        let lua = Login.UserAccount(userId: 1, name: "José", agency: "0642", bankAccount: "010234625", balance: 10.0)
        loginInte.doSomething(request: lua)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
