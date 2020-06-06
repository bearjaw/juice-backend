//
//  TestKit.swift
//  App
//
//  Created by Max Baumbach on 06/06/2020.
//

import XCTest

func assertTrue(@BooleanFunctionBuilder builder:  () -> [Bool]) {
    builder().forEach { XCTAssertTrue($0) }
}

func assertFalse(@BooleanFunctionBuilder builder:  () -> [Bool]) {
    builder().forEach { XCTAssertFalse($0) }
}

@_functionBuilder
final class BooleanFunctionBuilder {

    static func buildBlock(_ childern: Bool...) -> [Bool] {
        return childern
    }

}
