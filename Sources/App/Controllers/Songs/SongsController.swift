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

extension Song: Parameter {
    
    public static func resolveParameter(_ parameter: String, on container: Container) throws -> String {
        return ""
    }

    public typealias ResolvedParameter = String
}

final class SongsController: RouteCollection {

    enum SongsControllerError: Error {
        case notFound
    }

    func boot(router: Router) throws {
        let bearer = router.grouped(User.tokenAuthMiddleware())
        bearer.get("songs", use: search)
    }


    func search(_ req: Request) throws -> Future<Song> {
        let user = try req.requireAuthenticated(User.self)
        return try req.content.decode(Song.self).always {

        }
    }

}

