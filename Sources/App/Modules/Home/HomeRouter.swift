//
//  HomeRouter.swift
//  
//
//  Created by Max Baumbach on 27/12/2021.
//

import Vapor
import SwiftHtml

struct HomeRouter: RouteCollection {

    let controller = HomeController()

    func boot(routes: RoutesBuilder) throws {

        routes.get("") { req in
            req
                .templateRenderer
                .renderHtml(
                    WebIndexTemplate(context: WebIndexContext(title: "Juice")) {
                        Section {
                            Div {
                                H1 {
                                    Text("Create shared playlists")
                                }.class("display-5 fw-bold")
                                Div {
                                    P("Quickly create and customise your playlists and let anyone add a song to the queue.")
                                        .class("lead mb-4 detail-text")
                                }
                                .class("col-lg-6 mx-auto")
                            }
                            .class("px-4 py-5 my-5 text-center")
                        }
                    }
                )
        }
    }
}

/*
 H1 {
 Text("Create shared playlists")
 P("easy")
 }
 .class("d-block mx-auto mb-4")
 Div {
 Input()
 .type(.search)
 .class("search")
 .placeholder("Search for songs")
 }.class("col-lg-6 mx-auto")
 */
