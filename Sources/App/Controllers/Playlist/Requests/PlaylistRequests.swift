//
//  PlaylistRequests.swift
//  
//
//  Created by Max Baumbach on 07/06/2020.
//

import Vapor
import FluentSQLite

struct PlaylistListItemRequest: Content {

    let id: Int

    let remotePlaylistId: String

    let service: Playlist.Service?

}

struct CreatePlaylistRequest: Content {

    let remotePlaylistId: String

    let service: Playlist.Service?

    let title: String

    let description: String?

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

extension Playlist {

   convenience init(from request: CreatePlaylistRequest, userID: User.ID) {
    self.init(title: request.title,
              description: request.description,
              userID: userID,
              remotePlaylistId: request.remotePlaylistId,
              service: request.service)
    }
}
