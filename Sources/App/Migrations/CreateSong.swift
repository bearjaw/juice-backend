//
//  CreateSong.swift
//  
//
//  Created by Max Baumbach on 19/06/2020.
//

import Fluent

struct CreateSong: Migration {

    func prepare(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Song.schema)
            .id()
            .field("created_at", .date, .required)
            .field("updated_at", .date, .required)
            .field("title", .string, .required)
            .field("artist", .string, .required)
            .field("album", .string)
            .field("apple_music_id", .string)
            .create()
    }

    func revert(on database: Database) -> EventLoopFuture<Void> {
        return database.schema(Song.schema).delete()
    }

}
