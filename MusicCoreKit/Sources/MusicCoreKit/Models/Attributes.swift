//
//  Attributes.swift
//  
//
//  Created by Max Baumbach on 08/06/2020.
//

import Foundation

struct Attributes: Codable {

    let previews: [Preview]

    let artwork: Artwork

    let artistName: String

    let url: URL

    let discNumber: Int

    let genreNames: [String]

    let durationInMillis: Int

    let releaseDate: Date

    let name: String

    let isrc: String

    let hasLyrics: Bool

    let albumName: String

    let playParams: PlayParam

    let trackNumber: Int

    let composerName: String

}
