//
//  Song.swift
//  
//
//  Created by Max Baumbach on 08/06/2020.
//

import Foundation

struct Song: Codable {

    let id: String

    let type: String

    let href: String

    let attributes: Attributes

    let relationships: Relationships

}
