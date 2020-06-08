//
//  Song.swift
//  
//
//  Created by Max Baumbach on 08/06/2020.
//

import Foundation

public struct Song: Codable {

    public let id: String

    public let type: String

    public let href: String

    public let attributes: Attributes

    public let relationships: Relationships

}
