//
//  AppleMusicSearchModule.swift
//  
//
//  Created by Max Baumbach on 29/12/2021.
//

import Vapor

struct AppleMusicSearchModule: Module {

    var name: String = "search"

    var router: RouteCollection? { AppleMusicSearchRouter(token: token) }

    private let token: String

    init(token: String) {
        self.token = token
    }
}
