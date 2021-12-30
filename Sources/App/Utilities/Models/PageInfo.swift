//
//  PageInfo.swift
//  
//
//  Created by Max Baumbach on 30/12/2021.
//

import Foundation

struct PageInfo<T>: Encodable where T: Encodable {
    let pageData: T
    let webpageURL: String
    let now: Date
}
