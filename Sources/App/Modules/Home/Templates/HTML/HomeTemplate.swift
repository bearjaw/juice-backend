//
//  HomeTemplate.swift
//  
//
//  Created by Max Baumbach on 26/05/2022.
//

import Foundation
import SwiftHtml
import Vapor

struct HomeTemplate: TemplateRepresentable {

    func render(_ req: Request) -> Tag {
        Section {
            Div {
                Input()
                    .type(.search)
                    .class("search")
                    .placeholder("Search for songs")
            }
        }
    }
}
