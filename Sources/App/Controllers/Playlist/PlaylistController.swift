//
//  PlaylistController.swift
//  App
//
//  Created by Max Baumbach on 06/06/2020.
//

import Crypto
import Vapor
import FluentSQLite

final class PlaylistController: RouteCollection {

    enum PlaylistControllerError: Error {
        case notFound
    }

    func boot(router: Router) throws {
        let bearer = router.grouped(User.tokenAuthMiddleware())
        bearer.get("playlists","lists", use: list)
        bearer.get("playlists", Playlist.parameter, use: playlist)
        bearer.get("playlists", "all", use: all)
        bearer.post("playlists", use: create)
    }


    func list(_ req: Request) throws -> Future<[PlaylistListItemResponse]> {
        let user = try req.requireAuthenticated(User.self)

        return try Playlist.query(on: req)
            .filter(\.userID == user.requireID())
            .all()
            .map { $0.map(PlaylistListItemResponse.create(from:)) }
    }

    func playlist(_ req: Request) throws -> Future<Playlist> {

        let user = try req.requireAuthenticated(User.self)

        return try req.content.decode(PlaylistListItemRequest.self)
            .flatMap { item in

            return try Playlist.query(on: req)
                .filter(\.userID == user.requireID())
                .filter(\.id == item.id)
                .filter(\.remotePlaylistId == item.remotePlaylistId)
                .filter(\.service == item.service?.rawValue)
                .first()
                .unwrap(or: PlaylistControllerError.notFound)
        }
    }

    func all(_ req: Request) throws -> Future<UserToken> {
        // get user auth'd by basic auth middleware
        let user = try req.requireAuthenticated(User.self)

        // create new token for this user
        let token = try UserToken.create(userID: user.requireID())

        // save and return token
        return token.save(on: req)
    }

    func create(_ req: Request) throws -> Future<Playlist> {
        // get user auth'd by basic auth middleware
        let user = try req.requireAuthenticated(User.self)

        // save and return token
        return try req
            .content
            .decode(CreatePlaylistRequest.self)
            .flatMap {
                try Playlist(from: $0, userID: user.requireID())
                .save(on: req)
            }
    }
    
}