//
//  PlaylistsRouter.swift
//  
//
//  Created by Max Baumbach on 28/12/2021.
//

import Vapor

struct PlaylistsRouter: RouteCollection {

    private var controller: PlaylistsController!

    private let token: String

    /// Initialize the playlist router with a JWT Token
    /// required for authenticated Apple Music Requests
    ///
    /// - Parameter token: a JWT Token
    init(token: String) {
        self.token = token
        controller = PlaylistsController(token: token)

    }

    /// Boot the Search Contoller an pass in a valid JWT Token
    /// to use with Apple Music.
    ///
    /// - Parameters:
    ///   - routes: Router to register any new routes to.
    /// - Throws: An error when the token is empty or any route registration fails
    func boot(routes: RoutesBuilder) throws {
        guard token.isNonEmpty else { throw CommonAPIError.missingToken }
        routes.get("playlists", use: controller.playlistsView)
    }

}

