//
//  Playlist.swift
//  
//
//  Created by Max Baumbach on 19/06/2020.
//
import Fluent
import Vapor

final class Playlist: Model, Content {
    static let schema = "playlists"

    @ID(key: .id)
    var id: UUID?

    @Timestamp(key: "created_at", on: .create)
    var createdAt: Date?

    @Timestamp(key: "updated_at", on: .update)
    var updatedAt: Date?

    @Field(key: "title")
    var title: String

    @Field(key: "description")
    var description: String

    @Field(key: "items")
    var items: [UUID]

    @Field(key: "apple_music_id")
    var appleMusicId: String?

    init() { }

    init(id: UUID? = nil,
         title: String,
         description: String,
         appleMusicId: String?,
         items: [UUID] = []) {
        self.id = id
        self.title = title
        self.description = description
        self.items = items
        let date = Date()
        self.updatedAt = date
        self.createdAt = date
        self.appleMusicId = appleMusicId
    }
}
