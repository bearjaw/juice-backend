@testable import App
import Vapor
import XCTest

class AppTests: XCTestCase {

    func testPlaylistController_init() throws {
        XCTAssertTrue(PlaylistController())
    }
    
    static let allTests = [
        ("testPlaylistController_init", testPlaylistController_init),
    ]
}

