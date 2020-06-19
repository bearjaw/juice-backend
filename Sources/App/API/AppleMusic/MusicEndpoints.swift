//
//  File.swift
//  
//
//  Created by Max Baumbach on 09/06/2020.
//

import Foundation

enum MusicEndpoint: String {

    case activity
    case albums
    case artists
    case catalog
    case charts
    case curators
    case genres
    case history
    case me
    case playlist
    case ratings
    case recommendations
    case search
    case songs
    case videos

    static let base = "https://api.music.apple.com"

    static let version = "v1"

    var endpoint: String {
        let baseURL = "\(MusicEndpoint.base)/\(MusicEndpoint.version)/"
        return "\(baseURL)\(MusicEndpoint.catalog.rawValue)/us/\(self.rawValue)"
    }

}
