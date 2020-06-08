//
//  File.swift
//  
//
//  Created by Max Baumbach on 08/06/2020.
//

import Foundation

public struct Relationship: Codable {

    public let href: String

    public let data: [RelationshipData]

}
