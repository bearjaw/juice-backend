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

extension ResponseRoot: Content {}
extension Artwork: Content {}
extension Resource.Attributes: Content {}
extension PlayParam: Content {}
extension Preview: Content {}
extension Relationship: Content {}
extension RelationshipData: Content {}
extension Resource.Relationships: Content {}
extension Resource: Content {}
extension ResponseRoot.Results: Content {}
extension AppleMusicError: Content {}

struct AppleMusicSearchController: RouteCollection {

    private let token: String

    private let defaultLimit = "10"

    init(token: String) {
        self.token = token
    }

    enum AppleMusicSearchControllerError: Error {
        case notFound
        case missingToken
        case noTermProvided
        case invalidURL
    }

    /// Boot the Search Contoller an pass in a valid JWT Token
    /// to use with Apple Music.
    ///
    /// - Parameters:
    ///   - routes: Router to register any new routes to.
    /// - Throws: An error when the token is empty or any route registration fails
    func boot(routes: RoutesBuilder) throws {
        guard token.isNonEmpty else { throw AppleMusicSearchControllerError.missingToken }
        
        let searchGroup = routes.grouped("search")
        searchGroup.get(use: search)
    }

    // MARK: - Search Request

    func search(_ req: Request) throws -> EventLoopFuture<ResponseRoot> {
        guard token.isNonEmpty else { throw AppleMusicSearchControllerError.missingToken }

        let client = req.client

        let params = try req.query.decode(MusicSearchQueryParams.self)
        let urlString = MusicEnpoint.search.endpoint

        guard let url = try createQueryURL(urlString, params: params) else {
            throw AppleMusicSearchControllerError.invalidURL
        }

        let headers = HTTPHeaders(dictionaryLiteral:
            ("Authorization", "Bearer \(token)")
        )

        let uri = URI(string: url.absoluteString)
        
        return client
            .get(uri, headers: headers)
            .flatMapThrowing { response in
                return try response
                .content
                .decode(ResponseRoot.self)
        }
    }
}

// MARK: - Parse Query parameters

extension AppleMusicSearchController {

    func createQueryURL(_ url: String, params: MusicSearchQueryParams) throws -> URL? {
        let term = params.term
        var query: [URLQueryItem] = []
        guard term.isNonEmpty else { throw AppleMusicSearchControllerError.noTermProvided }
        query.append(
            URLQueryItem(name: "term", value: term)
        )

        if let types = params.types,
            types.isNonEmpty,
            let first = types.first {
            let typesString = types
                .dropFirst()
                .reduce(into: "\(first.rawValue)", { $0 = "\($0)," + $1.rawValue })
            query.append(
                URLQueryItem(name: "types", value: typesString)
            )
        }

        if let limit = params.limit {
            query.append(
                URLQueryItem(name: "limit", value: "\(limit)")
            )
        } else {
            query.append(
                URLQueryItem(name: "limit", value: defaultLimit)
            )
        }


        if let offset = params.offset {
            query.append(
                URLQueryItem(name: "offset", value: offset)
            )
        }


        var urlComps = URLComponents(string: url)
        urlComps?.queryItems = query
        return urlComps?.url
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
