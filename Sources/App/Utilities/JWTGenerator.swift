//
//  JWTGenerator.swift
//  
//
//  Created by Max Baumbach on 09/06/2020.
//

import JWT

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
        case es256
        case hs256

        var string: String {
            switch self {
            case .es256:
                return "ES256"
            case .hs256:
                return "HS256"
            }
        }
    }

    enum JWTGeneratorError: Error {
        case signing
    }

    /// Genrate a JWT Token
    ///
    /// - Parameters:
    ///   - pKey: The private key required to sign the token
    ///   - kId: The key ID
    ///   - iss: The token issuer id
    ///   - validity: The period the token should stay valid
    ///   - algorithm: The algorithm used
    /// - Throws: Throws a `JWTGeneratorError` if signing fails
    /// - Returns: The Token as a String
    static func generateToken(from pKey: String,
                              kId: String,
                              iss: String,
                              validity: Validity = .day,
                              algorithm: Algorithm = .hs256) throws -> String {

        let header = JWTHeader(alg: algorithm.string,
                               kid: kId)

        let iat = Date()
        let exp = iat.addingTimeInterval(validity.value).timeIntervalSince1970

        let payload = AppleMusicToken(iss: iss,
                                      iat: iat.timeIntervalSince1970,
                                      exp: exp)

        let data = try JWT(header: header, payload: payload).sign(using: .hs256(key: pKey))

        guard let token = String(data: data, encoding: .utf8) else {
            throw JWTGeneratorError.signing
        }

        return token
    }
    
}
