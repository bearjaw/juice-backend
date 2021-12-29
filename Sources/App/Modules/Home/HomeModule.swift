//
//  FrontendModule.swift
//  
//
//  Created by Max Baumbach on 27/12/2021.
//

import Foundation

import Vapor
import Fluent

struct FrontendModule: Module {

    var name: String = "home"

    var router: RouteCollection? { HomeRouter() }
}
