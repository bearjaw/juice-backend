//
//  File.swift
//  
//
//  Created by Max Baumbach on 29/12/2021.
//

import Vapor

struct MusicSearchQueryParams: Content {
    let term: String
    let limit: Int?
    let offset: String?
    let types: [MusicTypes]?
}

enum MusicTypes: String, Codable {
    case artists, albums, songs
}
