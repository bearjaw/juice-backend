//
//  SongsControllerTests.swift
//  
//
//  Created by Max Baumbach on 12/06/2020.
//

@testable import App
import Vapor
import XCTest

class AppleMusicSearchControllerTests: XCTestCase {

    func testSongsRouter_init() throws {
        XCTAssertNotNil(AppleMusicSearchRouter(token: "JWT"))
    }

    func testAppendParams_check_search_params() {

        let router = AppleMusicSearchRouter(token: "JWT")
        let urlString = MusicEndpoint.search.endpoint
        var params = MusicSearchQueryParams(term: "Jack+Black",
                                            limit: nil,
                                            offset: nil,
                                            types: nil)

        var got = try! router.createQueryURL(urlString, params: params)?.absoluteString

        var expectedURL = "\(MusicEndpoint.search.endpoint)?term=Jack+Black&limit=10"

        XCTAssertEqual(expectedURL, got,  failed(got as Any, expectedURL))

        params = MusicSearchQueryParams(term: "Jack+Black",
                                        limit: 20,
                                        offset: nil,
                                        types: [.albums, .artists])

        got = try! router.createQueryURL(urlString, params: params)?.absoluteString
        expectedURL = "\(MusicEndpoint.search.endpoint)?term=Jack+Black&types=albums,artists&limit=20"

        XCTAssertEqual(expectedURL, got, failed(got as Any, expectedURL))
    }

    func testAppendParams_check_search_params_throws() {
        let router = AppleMusicSearchRouter(token: "JWT")
        let url = MusicEndpoint.search.endpoint
        let params = MusicSearchQueryParams(term: "",
                                            limit: 0,
                                            offset: nil,
                                            types: nil)

        XCTAssertThrowsError(try router.createQueryURL(url, params: params),
                             "Should Throw because term is empty") { error in
                                XCTAssertEqual(AppleMusicSearchRouter
                                    .AppleMusicSearchRouterError
                                    .noTermProvided
                                    .localizedDescription,
                                               error
                                                .localizedDescription)
        }
    }

    static let allTests = [
        ("testSongsController_init", testSongsRouter_init),
        ("testAppendParams_check_search_params", testAppendParams_check_search_params)
    ]
}

func failed(_ got: Any, _ expected: Any) -> String {
    """
    \n
    \n
    \t  ===================================================
    \t  Test failed: Value mismatch.
    \t  ===================================================

    \t  Expected value to be: \(expected)


    \t  Got: \(got)

    \t  ===================================================
    \n
    \n
    """
}
