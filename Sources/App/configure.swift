import Fluent
import FluentPostgresDriver
import Vapor

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
