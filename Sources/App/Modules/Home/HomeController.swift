//
//  File.swift
//  
//
//  Created by Max Baumbach on 27/12/2021.
//

import Vapor

struct HomeController {

}


fileprivate struct ViewContext: Encodable {
    let title: String
    let header: String
    let message: String

}
