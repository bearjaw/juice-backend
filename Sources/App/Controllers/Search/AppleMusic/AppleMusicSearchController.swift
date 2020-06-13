//
//  SongsController.swift
//  
//
//  Created by Max Baumbach on 08/06/2020.
//

import Crypto
import Vapor
import Fluent
import MusicCore
import Logging

extension SongResult: Content {}
extension Artwork: Content {}
extension Attributes: Content {}
extension PlayParam: Content {}
extension Preview: Content {}
extension Relationship: Content {}
extension RelationshipData: Content {}
extension Relationships: Content {}
extension Song: Content {}

struct AppleMusicSearchController: RouteCollection {

    private let formatter = ISO8601DateFormatter()
    private let decoder = JSONDecoder()
    private let token: String

    init(token: String) {
        self.token = token
    }

    enum AppleMusicSearchControllerError: Error {
        case notFound
        case missingToken
    }

    /// Boot the Search Contoller an pass in a valid JWT Token
    /// to use with Apple Music.
    ///
    /// - Parameters:
    ///   - routes: Router to register any new routes to.
    /// - Throws: An error when the token is empty or any route registration fails
    func boot(routes: RoutesBuilder) throws {
        let searchGroup = routes.grouped("search")
        searchGroup.get(use: search)
    }

    // MARK: - Search Request

    func search(_ req: Request) throws -> EventLoopFuture<[Song]> {
        guard token.isNonEmpty else { throw AppleMusicSearchControllerError.missingToken }

        let client = req.client

        let params = try req.query.decode(MusicSearchQueryParams.self)
        var url = MusicEnpoint.search.endpoint

        appendQuery(&url, params: params)

        let headers = HTTPHeaders(dictionaryLiteral:
            ("Authorization", "Bearer \(token)")
        )


        let uri = URI(string: url)
        decoder.dateDecodingStrategy = DateDecoder.decodeDate(using: self.formatter)
        return client
            .get(uri, headers: headers)
            .flatMapThrowing { response in
                return try response
                .content
                .decode(SongResult.self, using: self.decoder)
                .data
        }
    }
}

// MARK: - Parse Query parameters

extension AppleMusicSearchController {

    func appendQuery(_ url: inout String, params: MusicSearchQueryParams) {
        let term = "?term=\(params.term)"
        let params = "\(term)"
        url.append(params)
    }
}

struct MusicSearchQueryParams: Content {
    let term: String
    let limit: Int?
    let offset: String?
    let types: [MusicTypes]?
}

enum MusicTypes: String, Codable {
    case artists, albums, songs
}
