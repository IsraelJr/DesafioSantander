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

    func test_isValidEmail() {
        XCTAssertTrue(isValidEmail(emailUser: "asdf@gmail.com"))
    }
    
    func test_isValidCpf() {
        XCTAssertTrue(isValidCPF(cpfUser: "12345678901"))
        XCTAssertTrue(isValidCPF(cpfUser: "123.456.789-01"))
    }
    
    func test_isValidPassword() {
        XCTAssertTrue(isValidPassword(passwordUser: "A!1"))
    }

}
