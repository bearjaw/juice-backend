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
        return req.application.leaf.renderer.render(path: "index", context: [
            "title": .string("Juice - Playlist"),
            "header": .string("Hi there, "),
            "message": .string("welcome to my awesome page!")
        ]).map { v in
            return View(data: v)
        }
    }

}
