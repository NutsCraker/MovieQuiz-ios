//
//  MovieQuizTests.swift
//  MovieQuizTests
//
//  Created by Alexander Farizanov on 27.12.2022.
//

import XCTest
class MovieQuizTests: XCTestCase {
    func testAddition() throws {
        //Given
        let arithmeticOperations = ArithmeticOperations()
        let num1 = 1
        let num2 = 2
        
        //When
        let expectation = expectation(description: "Addution function expectation")
        arithmeticOperations.addition(num1: num1, num2: num2) { result in
            
            //Then
            XCTAssertEqual(result, 3)
            expectation.fulfill()
        }
        waitForExpectations(timeout: 2)

    }
}
