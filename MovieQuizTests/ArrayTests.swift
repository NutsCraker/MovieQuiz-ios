//
//  ArrayTests.swift
//  MovieQuizTests
//
//  Created by Alexander Farizanov on 26.12.2022.
//
import Foundation
import XCTest
@testable import MovieQuiz
class ArrayTests: XCTestCase {
    func testGetValueInRange() throws {
        //Given
        let array = [1, 2, 3, 4, 5, 6]
        
        // When
        let value = array[safe: 2]
        
        // Then
        XCTAssertNotNil(value)
        XCTAssertEqual(value, 3)
    }
    
    func testGetValueOutOfRange() throws {
        // Given
        let array = [1, 2, 3, 4, 5, 6]
        
        // When
        let value = array[safe: 20]
        
        // Then
        XCTAssertNil(value)
    }
}
