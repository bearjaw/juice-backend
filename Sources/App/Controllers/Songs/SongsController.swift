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

final class SongsController: RouteCollection {

    private let formatter = ISO8601DateFormatter()
    private let decoder = JSONDecoder()

    enum SongsControllerError: Error {
        case notFound
    }

    func boot(router: Router) throws {
//        let bearer = router.grouped(User.tokenAuthMiddleware())
        router.get(MusicEnpoint.search.rawValue, use: search)
        router.get(MusicEnpoint.artists.rawValue, use: search)
    }


    func search(_ req: Request) throws -> Future<[Song]> {

        let client = try req.client()
        let token = "Insert Your JWT Token here"

        let params = try req.query.decode(MusicSearchQueryParams.self)
        var url = MusicEnpoint.search.endpoint
        appendQuery(&url, params: params)
        let headers = HTTPHeaders(
            [
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

extension SongsController {

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
