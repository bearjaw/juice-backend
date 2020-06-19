//
//  Song.swift
//  
//
//  Created by Max Baumbach on 19/06/2020.
//

import Foundation

import Fluent
import Vapor

final class Song: Model, Content {
    static let schema = "playlists"

    @ID(key: .id)
    var id: UUID?

    @Field(key: "title")
    var title: String

    @Field(key: "artist")
    var artist: String

    @Field(key: "album")
    var album: String?

    init() { }

    init(id: UUID? = nil,
         title: String,
         artist: String,
         album: String? = nil) {
        self.id = id
        self.title = title
        self.artist = artist
        self.album = album
    }
}
