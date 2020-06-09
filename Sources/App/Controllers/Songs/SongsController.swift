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

    enum SongsControllerError: Error {
        case notFound
    }

    func boot(router: Router) throws {
//        let bearer = router.grouped(User.tokenAuthMiddleware())
        router.get("songs", use: search)
    }


    func search(_ req: Request) throws -> Future<[Song]> {

        let client = try req.client()
        let url = "\(MusicEnpoint.base)/\(MusicEnpoint.version)/catalog/us/songs/203709340"

        let headers = HTTPHeaders([("Authorization", "")])

        return client.get(url, headers: headers).flatMap({ result in
            return try result.content.decode(SongResult.self)
                .map( { response in return response.data })
        })
    }

}
