//
//  File.swift
//  
//
//  Created by Max Baumbach on 13/06/2020.
//

import Foundation

extension Collection {

    var isNonEmpty: Bool {
        !isEmpty
    }

}

extension String {

    var bytes: [UInt8] {
        return .init(self.utf8)
    }
    
}
