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

    func add(_ req: Request) throws -> Future<UserToken> {
        // get user auth'd by basic auth middleware
        let user = try req.requireAuthenticated(User.self)

        // create new token for this user
        let token = try UserToken.create(userID: user.requireID())

        // save and return token
        return token.save(on: req)
    }

    func remove(_ req: Request) throws -> Future<UserToken> {
        // get user auth'd by basic auth middleware
        let user = try req.requireAuthenticated(User.self)

        // create new token for this user
        let token = try UserToken.create(userID: user.requireID())

        // save and return token
        return token.save(on: req)
    }
    
}
