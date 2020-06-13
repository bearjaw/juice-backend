//
//  JWTGenerator.swift
//  
//
//  Created by Max Baumbach on 09/06/2020.
//

import JWT
import Foundation
import Vapor

struct JWTGenerator {

    enum Validity {
        case day
        case custom(TimeInterval)

        var value: TimeInterval {
            switch self {
            case .day:
                return 60*60*24
            case let .custom(value):
                return value
            }
        }
    }

    enum Algorithm {
        case es256(data: Data)

        var string: String {
            switch self {
            case .es256:
                return "ES256"
            }
        }

    }

    enum JWTGeneratorError: Error {
        case signing
    }

    /// Genrate a JWT Token
    ///
    /// - Parameters:
    ///   - kId: The key ID
    ///   - iss: The token issuer id
    ///   - validity: The period the token should stay valid
    ///   - algorithm: The algorithm used
    /// - Throws: Throws a `JWTGeneratorError` if signing fails
    /// - Returns: The Token as a String
    static func generatePayload(kId: String,
                              iss: String,
                              validity: Validity = .day) throws -> AppleMusicJWTPayload {

        
        let iat = Date()
        let exp = iat.addingTimeInterval(validity.value).timeIntervalSince1970.rounded()

        let payload = AppleMusicJWTPayload(iss: iss,
                                      iat: iat.timeIntervalSince1970.rounded(),
                                      exp: exp)

        return payload
    }
    
}
