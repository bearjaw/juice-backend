//
//  WebIndexTemplate.swift
//  
//
//  Created by Max Baumbach on 26/05/2022.
//

import Foundation
import SwiftHtml
import SwiftSvg
import Vapor


extension Svg {
    static func menuIcon() -> Svg {
        Svg {
            Line(x1: 3, y1: 12, x2: 21, y2: 12)
            Line(x1: 3, y1: 6, x2: 21, y2: 6)
            Line(x1: 3, y1: 18, x2: 21, y2: 18)
        }
        .width(24)
        .height(24)
        .viewBox(minX: 0, minY: 0, width: 24, height: 24)
        .fill("none")
        .stroke("currentColor")
        .strokeWidth(2)
        .strokeLinecap("round")
        .strokeLinejoin("round")
    }
}

struct WebIndexTemplate: TemplateRepresentable {

    public var context: WebIndexContext
    private var body: Tag

    public init(context: WebIndexContext, @TagBuilder _ builder: () -> Tag) {
        self.context = context
        self.body = builder()
    }

    @TagBuilder
    func render(_ req: Request) -> Tag {
        Html {
            Head {
                Meta()
                    .charset("utf-8")

                Meta()
                    .name(.viewport)
                    .content("width=device-width, initial-scale=1")

                Link(rel: .shortcutIcon)
                    .href("/img/favicon.ico")
                    .type("image/x-icon")

                Link(rel: .stylesheet)
                    .href("/css/feather.min.css")

                Link(rel: .stylesheet)
                    .href("/css/web.css")

                Title(context.title)
            }
            Body {
                Header {
                    Div {
                        Nav {
                            Label {
                                Svg.menuIcon()
                            }
                            .for("primary-menu-button")
                                    Div {
                                A("Home")
                                    .href("/")
                                    .class("selected", req.url.path == "/")
                                A("Playlists")
                                    .href("/playlists/")
                                    .class("selected", req.url.path == "/playlists/")
                                A("About")
                                    .href("#")
                                    .onClick("javascript:about();")
                            }
                            .class("menu-items")
                        }
                        .id("primary-menu")
                    }
                    .id("navigation")
                }

                Main {
                    body
                }.class("default-background")

            }
            .class("default-background")
            .lang("en-GB")
        }
    }
}
