import Crypto
import Vapor

/// Register your application's routes here.
public func routes(_ router: Router) throws {
    // public routes
    let userController = UserController()
    router.post("users", use: userController.create)
    
    // basic / password auth protected routes
    let basic = router.grouped(User.basicAuthMiddleware(using: BCryptDigest()))
    basic.post("login", use: userController.login)

    let playlistController = PlaylistController()
    try playlistController.boot(router: router)

    let songsController = AppleMusicSearchController()
    let token = try JWTGenerator.createAppleMusicToken()
    try songsController.boot(router: router, with: token)
}
