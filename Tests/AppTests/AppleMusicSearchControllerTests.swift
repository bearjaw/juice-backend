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

    func testSongsController_init() throws {
        XCTAssertNotNil(AppleMusicSearchController(token: "JWT"))
    }

    func testAppendParams_check_search_params() {

        let controller = AppleMusicSearchController(token: "JWT")
        let urlString = MusicEnpoint.search.endpoint
        var params = MusicSearchQueryParams(term: "Jack+Black",
                                            limit: nil,
                                            offset: nil,
                                            types: nil)

        var got = try! controller.createQueryURL(urlString, params: params)?.absoluteString

        var expectedURL = "\(MusicEnpoint.search.endpoint)?term=Jack+Black&limit=10"

        XCTAssertEqual(expectedURL, got,  failed(got as Any, expectedURL))

        params = MusicSearchQueryParams(term: "Jack+Black",
                                        limit: 20,
                                        offset: nil,
                                        types: [.albums, .artists])

        got = try! controller.createQueryURL(urlString, params: params)?.absoluteString
        expectedURL = "\(MusicEnpoint.search.endpoint)?term=Jack+Black&types=albums,artists&limit=20"

        XCTAssertEqual(expectedURL, got, failed(got as Any, expectedURL))
    }

    func testAppendParams_check_search_params_throws() {
        let controller = AppleMusicSearchController(token: "JWT")
        let url = MusicEnpoint.search.endpoint
        let params = MusicSearchQueryParams(term: "",
                                            limit: 0,
                                            offset: nil,
                                            types: nil)

        XCTAssertThrowsError(try controller.createQueryURL(url, params: params),
                             "Should Throw because term is empty") { error in
                                XCTAssertEqual(AppleMusicSearchController
                                    .AppleMusicSearchControllerError
                                    .noTermProvided
                                    .localizedDescription,
                                               error
                                                .localizedDescription)
        }
    }

    static let allTests = [
        ("testSongsController_init", testSongsController_init),
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
