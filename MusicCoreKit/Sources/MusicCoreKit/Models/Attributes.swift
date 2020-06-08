//
//  Attributes.swift
//  
//
//  Created by Max Baumbach on 08/06/2020.
//

import Foundation

public struct Attributes: Codable {

    public let previews: [Preview]

    public let artwork: Artwork

    public let artistName: String

    public let url: URL

    public let discNumber: Int

    public let genreNames: [String]

    public let durationInMillis: Int

    public let releaseDate: Date

    public let name: String

    public let isrc: String

    public let hasLyrics: Bool

    public let albumName: String

    public let playParams: PlayParam

    public let trackNumber: Int

    public let composerName: String

}
