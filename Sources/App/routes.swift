import Fluent
import JWT
import Vapor

func routes(_ app: Application) throws {

    try app.register(collection: TodoController())

    try JWTGenerator.registerAppleMusicSigner(using: app)

    let token = try JWTGenerator.generateAppleMusicToken(using: app)

    let search = AppleMusicSearchController(token: token)
    
    let playlist = PlaylistController(token: token)

    try app.register(collections: [
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

