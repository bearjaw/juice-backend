import Fluent
import Vapor

func routes(_ app: Application) throws {
    try app.register(collection: TodoController())

    let token = "Your Apple Music JWT Token here"
    let controller = AppleMusicSearchController(token: token)
    try app.register(collection: controller)
}
