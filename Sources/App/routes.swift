import Fluent
import JWT
import Vapor

func routes(_ app: Application) throws {

    try app.register(collection: TodoController())

    try JWTGenerator.registerAppleMusicSigner(using: app)

    let token = try JWTGenerator.generateAppleMusicToken(using: app)

    let controller = AppleMusicSearchController(token: token)

    try app.register(collection: controller)
    
}
