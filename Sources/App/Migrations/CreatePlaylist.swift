//
//  CreatePlaylist.swift
//  
//
//  Created by Max Baumbach on 19/06/2020.
//

import Fluent

struct CreatePlaylist: Migration {

    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Playlist.schema)
            .id()
            .field("created_at", .date, .required)
            .field("updated_at", .date, .required)
            .field("title", .string, .required)
            .field("description", .string)
            .field("items", .array(of: .uuid))
            .field("apple_music_id", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Playlist.schema).delete()
    }

}
