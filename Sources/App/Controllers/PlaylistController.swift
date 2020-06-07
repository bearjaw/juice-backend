//
//  PlaylistController.swift
//  App
//
//  Created by Max Baumbach on 06/06/2020.
//

import Crypto
import Vapor
import FluentSQLite

final class PlaylistController {

    enum PlaylistControllerError: Error {
        case notFound
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
                .filter(\.remotePlaylistId == item.remoteId)
                .filter(\.service == item.service)
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
    
}

struct PlaylistListItemRequest: Content {

    let id: Int

    let remoteId: String

    let service: Playlist.Service?

}

struct PlaylistListItemResponse: Content {

    let id: Int

    let title: String

    let description: String?

    let itemCount: Int

}

extension PlaylistListItemResponse {

    static func create(from playlist: Playlist) -> PlaylistListItemResponse {
        PlaylistListItemResponse(id: playlist.id ?? 0,
                                 title: playlist.title,
                                 description: playlist.description,
                                 itemCount: 0)
    }

}

