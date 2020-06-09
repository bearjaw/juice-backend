//
//  SongsController.swift
//  
//
//  Created by Max Baumbach on 08/06/2020.
//

import Crypto
import Vapor
import FluentSQLite
import MusicCoreKit

extension Song: Content {}

extension Song: Parameter {}

final class SongsController: RouteCollection {

    enum SongsControllerError: Error {
        case notFound
    }

    func boot(router: Router) throws {
        let bearer = router.grouped(User.tokenAuthMiddleware())
        bearer.get("songs", use: search)
    }


    func search(_ req: Request) throws -> Future<[Song]> {
        let user = try req.requireAuthenticated(User.self)

        let client = try req.client()
//        client.get("", headers: <#T##HTTPHeaders#>, beforeSend: <#T##(Request) throws -> ()#>)
        return try Playlist.query(on: req)
            .filter(\.userID == user.requireID())
            .all()
            .map { $0.map(PlaylistListItemResponse.create(from:)) }
    }

}

