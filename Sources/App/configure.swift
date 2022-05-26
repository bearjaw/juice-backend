import JWT
import Fluent
import FluentSQLiteDriver
import Vapor

// configures your application
public func configure(_ app: Application) throws {

    app.logger.logLevel =  app.environment.isRelease ? .info : .debug

    // uncomment to serve files from /Public folder
    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    /// extend paths to always contain a trailing slash
    app.middleware.use(ExtendPathMiddleware())

//    app.databases.use(.sqlite(
//        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
//        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
//        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
//        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
//    ), as: .sqlite)


    app.migrations.add(CreateTodo())
    app.migrations.add(CreateSong())
    app.migrations.add(CreatePlaylist())

    let decoder = JSONDecoder()
    let formatter = ISO8601DateFormatter()
    formatter.formatOptions = [.withInternetDateTime,
                               .withDashSeparatorInDate,
                               .withColonSeparatorInTimeZone]
    decoder.dateDecodingStrategy = DateDecoder.decodeDate(using: formatter)
    
    ContentConfiguration.global.use(decoder: decoder, for: .json)

    // register routes
    try routes(app)
}

extension Environment {

    // service bundle identifier
    static var amId = Environment.get("AM_ID")!

    // team identifier
    static var amTeamId = Environment.get("AM_TEAM_ID")!

    // key identifier
    static var amJWKId = Environment.get("AM_JWK_ID")!

}

extension JWKIdentifier {

    static let appleMusic = JWKIdentifier(string: Environment.amJWKId)
}

@available(macOS 12, *)
struct ExtendPathMiddleware: AsyncMiddleware {

    func respond(to req: Request, chainingTo next: AsyncResponder) async throws -> Response {
        if !req.url.path.hasSuffix("/") && !req.url.path.contains(".") {
            return req.redirect(to: req.url.path + "/", type: .permanent)
        }
        return try await next.respond(to: req)
    }
}
