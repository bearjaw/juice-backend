//
//  PlaylistController.swift
//  
//
//  Created by Max Baumbach on 19/06/2020.
//

import Foundation
import Vapor
import MusicCore

struct PlaylistController: RouteCollection {

    private let token: String

    /// Initialize the playlist controller with a JWT Token
    /// required for authenticated Apple Music Requests
    ///
    /// - Parameter token: a JWT Token
    init(token: String) {
        self.token = token
    }

    /// Boot the Search Contoller an pass in a valid JWT Token
    /// to use with Apple Music.
    ///
    /// - Parameters:
    ///   - routes: Router to register any new routes to.
    /// - Throws: An error when the token is empty or any route registration fails
    func boot(routes: RoutesBuilder) throws {
        guard token.isNonEmpty else { throw CommonAPIError.missingToken }

        let playlistsGroup = routes.grouped("playlists")
        playlistsGroup.get(use: index)
        playlistsGroup.post(use: create)
        playlistsGroup.patch(use: update)
        playlistsGroup.delete(use: delete)
    }

    func index(_ req: Request) throws -> HTTPStatus {
        guard token.isNonEmpty else { throw CommonAPIError.missingToken }
        return .notImplemented
    }

    func create(_ req: Request) throws -> HTTPStatus {
          guard token.isNonEmpty else { throw CommonAPIError.missingToken }

          return .notImplemented
    }

    func update(_ req: Request) throws -> HTTPStatus {
        guard token.isNonEmpty else { throw CommonAPIError.missingToken }

        return .notImplemented
    }

    func delete(_ req: Request) throws -> HTTPStatus {
        guard token.isNonEmpty else { throw CommonAPIError.missingToken }

        return .notImplemented
    }

}
