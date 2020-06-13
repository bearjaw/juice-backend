import Fluent
import FluentPostgresDriver
import Vapor
import JWT

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
    ), as: .psql)

    app.migrations.add(CreateTodo())
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

    // contents of the downloaded key file
    static var amKey = Environment.get("AM_KEY")!

}

extension JWKIdentifier {

    static let appleMusic = JWKIdentifier(string: Environment.amJWKId)
}
