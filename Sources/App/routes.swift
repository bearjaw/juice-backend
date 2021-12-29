import Fluent
import JWT
import Vapor

func routes(_ app: Application) throws {

    try JWTGenerator.registerAppleMusicSigner(using: app)

    let token = try JWTGenerator.generateAppleMusicToken(using: app)

    let home = HomeRouter()

    let search = AppleMusicSearchRouter(token: token)
    
    let playlist = PlaylistRouter(token: token)

    try app.register(collections: [
        home,
        search,
        playlist
    ])
    
}

extension RoutesBuilder {

    /// Registers all of the routes in the group to this router.
    ///
    /// - parameters:
    ///     - collection: `RouteCollection` to register.
    public func register(collections: [RouteCollection]) throws {
        try collections.forEach(register(collection:))
    }

}

