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
        let context = ViewContext(title: "Juice - Home", header: "Hi there, ", message: "welcome to my awesome page!")
        return req.render("index", context)
    }

}


fileprivate struct ViewContext: Encodable {
    let title: String
    let header: String
    let message: String

}
