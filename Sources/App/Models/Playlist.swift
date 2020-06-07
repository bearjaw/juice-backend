//
//  PlaylistListItem.swift
//  App
//
//  Created by Max Baumbach on 07/06/2020.
//

import FluentSQLite
import Vapor

/// A single entry of a todo list.
final class Playlist: SQLiteModel {

    enum Service: String, Codable {
        case apple
    }

    typealias Database = SQLiteDatabase

    /// The unique identifier for this `Playlist`.
    var id: Int?

    /// The name of the `Playlist`
    var title: String

    /// An optional description describing what this `Playlist` entails.
    var description: String?

    /// Reference to user that owns this `Playlist`.
    var userID: User.ID

    /// A playlist identifer of a third party service
    var remotePlaylistId: String?

    /// The service where the playlist originates
    var service: String?

    /// Creates a new `Playlist`.
    init(id: Int? = nil,
         title: String,
         description: String?,
         userID: User.ID,
         remotePlaylistId: String?,
         service: Service?) {
        self.id = id
        self.title = title
        self.description = description
        self.userID = userID
        self.remotePlaylistId = remotePlaylistId
        self.service = service?.rawValue
    }
}

extension Playlist {
    /// Fluent relation to user that owns this todo.
    var user: Parent<Playlist, User> {
        return parent(\.userID)
    }
}

/// Allows `Todo` to be used as a Fluent migration.
extension Playlist: Migration {
    static func prepare(on conn: SQLiteConnection) -> Future<Void> {
        return SQLiteDatabase.create(Playlist.self, on: conn) { builder in
            builder.field(for: \.id, isIdentifier: true)
            builder.field(for: \.title)
            builder.field(for: \.description)
            builder.field(for: \.service)
            builder.field(for: \.remotePlaylistId)
            builder.field(for: \.userID)
            builder.reference(from: \.userID, to: \User.id)
        }
    }
}

extension Playlist: Content { }

extension Playlist: Parameter { }
