//
//  PlaylistController.swift
//  
//
//  Created by Max Baumbach on 19/06/2020.
//

import Leaf
import MusicCore
import Vapor

struct PlaylistController {
 
    // MARK: - View

    func homeView(req: Request) throws -> EventLoopFuture<View> {
        return req.render("index", [
            "title": "Juice - Playlist",
            "header": "Hi there, ",
            "message": "welcome to my awesome page!"
        ])
    }

}
