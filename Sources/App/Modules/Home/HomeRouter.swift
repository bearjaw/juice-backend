//
//  File.swift
//  
//
//  Created by Max Baumbach on 27/12/2021.
//

import Vapor

struct HomeRouter: RouteCollection {

    let controller = HomeController()

    func boot(routes: RoutesBuilder) throws {
        print("yoo")

        routes.get(use: controller.homeView)
    }
}
