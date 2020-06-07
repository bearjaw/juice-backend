@testable import App
import Vapor
import XCTest

class AppTests: XCTestCase {

    func testPlaylistController_init() throws {
        XCTAssertNotNil(PlaylistController())
    }

    func testBoot_registers_routes() {
        let controller = PlaylistController()
        let router = EngineRouter.default()
        XCTAssertNoThrow(try controller.boot(router: router))
    }
    
    static let allTests = [
        ("testPlaylistController_init", testPlaylistController_init),
        ("testBoot_registers_routes", testBoot_registers_routes)
    ]
}
