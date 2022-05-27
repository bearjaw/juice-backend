//
//  PlaylistsModule.swift
//  
//
//  Created by Max Baumbach on 28/12/2021.
//

import Vapor

struct PlaylistsModule: Module {

    var name: String = "playlist"

    var router: RouteCollection? { PlaylistsRouter(token: token) }

    private let token: String

    init(token: String) {
        self.token = token
    }
}
