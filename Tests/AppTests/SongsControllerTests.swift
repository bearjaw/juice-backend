//
//  SongsControllerTests.swift
//  
//
//  Created by Max Baumbach on 12/06/2020.
//

@testable import App
import Vapor
import XCTest

class SongsControllerTests: XCTestCase {

    func testSongsController_init() throws {
        XCTAssertNotNil(AppleMusicSearchController())
    }

    func testBoot_registers_routes() {
        let controller = AppleMusicSearchController()
        let router = EngineRouter.default()
        XCTAssertNoThrow(try controller.boot(router: router))
    }

    func testAppendParams_check_search_params() {
        let controller = AppleMusicSearchController()
        var url = MusicEnpoint.search.endpoint
        let params = MusicSearchQueryParams(term: "Jack+Black", limit: 0, offset: nil, types: nil)
        controller.appendQuery(&url, params: params)

        XCTAssertEqual("\(MusicEnpoint.search.endpoint)?term=Jack+Black", url)
    }

    static let allTests = [
        ("testSongsController_init", testSongsController_init),
        ("testBoot_registers_routes", testBoot_registers_routes),
        ("testAppendParams_check_search_params", testAppendParams_check_search_params)
    ]
}
