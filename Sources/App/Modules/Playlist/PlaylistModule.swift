//
//  PlaylistModule.swift
//  
//
//  Created by Max Baumbach on 28/12/2021.
//

import Vapor

struct PlaylistModule: Module {

    var name: String = "playlist"

    var router: RouteCollection? { PlaylistRouter(token: token) }

    private let token: String

    init(token: String) {
        self.token = token
    }
}
