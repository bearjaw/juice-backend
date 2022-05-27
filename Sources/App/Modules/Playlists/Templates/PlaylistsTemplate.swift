//
//  PlaylistsTemplate.swift
//  
//
//  Created by Max Baumbach on 27/05/2022.
//

import Foundation
import SwiftHtml
import Vapor

struct PlaylistsTemplate: TemplateRepresentable {

    private let context: PlaylistsContext

    init(context: PlaylistsContext) {
        self.context = context
    }

    func render(_ req: Request) -> Tag {
        WebIndexTemplate(context: WebIndexContext(title: "Juice")) {
            Div {
                for playlist in context.playlists {
                    Div {
                        A {
                            H2(playlist.title)
                            P(playlist.description)
                        }
                    }
                }
            }
        }.render(req)
    }
}
