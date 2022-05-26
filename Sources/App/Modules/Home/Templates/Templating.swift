//
//  File.swift
//  
//
//  Created by Max Baumbach on 26/05/2022.
//

import Foundation

import Vapor
import SwiftSgml
import SwiftHtml

public protocol TemplateRepresentable {
    @TagBuilder
    func render(_ req: Request) -> Tag
}


public struct TemplateRenderer {

    var req: Request

    init(_ req: Request) {
        self.req = req
    }

    public func renderHtml(_ template: TemplateRepresentable, minify: Bool = false, indent: Int = 4) -> Response {
        let doc = Document(.html) { template.render(req) }
        let body = DocumentRenderer(minify: minify, indent: indent).render(doc)

        return Response(status: .ok,
                        headers: ["content-type": "text/html"],
                        body: .init(string: body))
    }

}

public extension Request {
    var templateRenderer: TemplateRenderer { .init(self) }
}
