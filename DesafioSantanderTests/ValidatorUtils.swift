//
//  ValidatorUtils.swift
//  DesafioSantanderTests
//
//  Created by Israel Alves Santos Junior on 11/07/19.
//  Copyright © 2019 Israel Alves Santos Junior. All rights reserved.
//

import XCTest
@testable import DesafioSantander

class ValidatorUtils: XCTestCase {

    override func setUp() {
        print("função setUp")
    }

    override func tearDown() {
        print("função tearDown")
    }

    func test_isValidEmail() {
        let email = "asdf@gmail.com"
        let result = isValidEmail(emailUser: email)
        XCTAssertTrue(result)
        print("função test_isValidEmail")
    }
    
    func test_isValidCpf() {
        let cpf = "12345678901"
        let result = isValidCPF(cpfUser: cpf)
        XCTAssertTrue(result)
        print("função test_isValidCpf")
    }
    
    func test_isValidPassword() {
        let password = "A!1"
        let result = isValidPassword(passwordUser: password)
        XCTAssertTrue(result)
        print("função test_isValidPassword")
    }
    
    func testPerformanceExample() {
        print("função testPerformanceExample")
        // This is an example of a performance test case.
        self.measure {
            print("função testPerformanceExample measure")
            // Put the code you want to measure the time of here.
        }
    }

}
