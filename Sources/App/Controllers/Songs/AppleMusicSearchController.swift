//
//  SongsController.swift
//  
//
//  Created by Max Baumbach on 08/06/2020.
//

import Crypto
import Vapor
import FluentSQLite
import MusicCore

extension SongResult: Content {}
extension Artwork: Content {}
extension Attributes: Content {}
extension PlayParam: Content {}
extension Preview: Content {}
extension Relationship: Content {}
extension RelationshipData: Content {}
extension Relationships: Content {}
extension Song: Content {}

extension Song: Parameter {
    
    public static func resolveParameter(_ parameter: String, on container: Container) throws -> String {
        return parameter
    }

    public typealias ResolvedParameter = String
}

final class AppleMusicSearchController: RouteCollection {

    private let formatter = ISO8601DateFormatter()
    private let decoder = JSONDecoder()
    private var token = ""

    enum AppleMusicSearchControllerError: Error {
        case notFound
        case missingToken
    }

    /// Boot the Search Contoller an pass in a valid JWT Token
    /// to use with Apple Music.
    ///
    /// - Parameters:
    ///   - router: Router to register any new routes to.
    ///   - token: ES256 encrypted JWT Token
    /// - Throws: An error when the token is empty or any route registration fails
    func boot(router: Router, with token: String) throws {
        self.token = token
        try boot(router: router)
    }

    func boot(router: Router) throws {
        router.get(MusicEnpoint.search.rawValue, use: search)
        router.get(MusicEnpoint.artists.rawValue, use: search)
    }


    func search(_ req: Request) throws -> Future<[Song]> {
        guard token.isNonEmpty else { throw AppleMusicSearchControllerError.missingToken }

        let client = try req.client()

        let params = try req.query.decode(MusicSearchQueryParams.self)
        var url = MusicEnpoint.search.endpoint
        

        appendQuery(&url, params: params)
        let headers = HTTPHeaders([
            ("Authorization", "Bearer \(token)")
        ])

        return client.get(url, headers: headers).flatMap { result in

            self.decoder.dateDecodingStrategy = DateDecoder.decodeDate(using: self.formatter)
            
            return try result.content.decode(SongResult.self, using: self.decoder)
                .map { response in
                    return response.data
            }

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
