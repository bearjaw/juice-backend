import JWT
import Fluent
import FluentPostgresDriver
import LeafKit
import Leaf
import Vapor

// configures your application
public func configure(_ app: Application) throws {
    // uncomment to serve files from /Public folder

    app.logger.logLevel =  app.environment.isRelease ? .info : .debug

    app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))

    app.views.use(.leaf)

    app.leaf.sources = .singleSource(NIOLeafFiles(fileio: app.fileio,
                                                  limits: .default,
                                                  sandboxDirectory: app.leaf.configuration.rootDirectory,
                                                  viewDirectory: app.leaf.configuration.rootDirectory,
                                                  defaultExtension: "html"))

    app.databases.use(.postgres(
        hostname: Environment.get("DATABASE_HOST") ?? "localhost",
        username: Environment.get("DATABASE_USERNAME") ?? "vapor_username",
        password: Environment.get("DATABASE_PASSWORD") ?? "vapor_password",
        database: Environment.get("DATABASE_NAME") ?? "vapor_database"
    ), as: .psql)


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
