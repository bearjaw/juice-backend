//
//  File.swift
//  
//
//  Created by Max Baumbach on 27/12/2021.
//

import Leaf
import Vapor

struct HomeController {

    func homeView(req: Request) throws -> EventLoopFuture<View> {
        return req.application.leaf.renderer.render(path: "index", context: [
            "title": .string("Juice - Home"),
            "header": .string("Hi there, "),
            "message": .string("welcome to my awesome page!")
        ]).map { v in
            return View(data: v)
        }
    }

}
