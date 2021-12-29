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

    enum JWTGeneratorError: Error {
        case signing
    }

    /// Genrate a JWT Token
    ///
    /// - Parameters:
    ///   - iss: The token issuer id
    ///   - validity: The period the token should stay valid
    /// - Throws: Throws a `JWTGeneratorError` if signing fails
    /// - Returns: The Token as a String
    static func generatePayload(iss: String,
                                validity: Validity = .day) throws -> AppleMusicJWTPayload {

        
        let iat = Date()
        let exp = iat.addingTimeInterval(validity.value).timeIntervalSince1970.rounded()

        let payload = AppleMusicJWTPayload(iss: iss,
                                      iat: iat.timeIntervalSince1970.rounded(),
                                      exp: exp)

        return payload
    }
    
}

extension JWTGenerator {

    static func generateAppleMusicToken(using app: Application,
                              from payload: AppleMusicJWTPayload,
                              kid: JWKIdentifier? = nil) throws -> String {
        return try app.jwt.signers.sign(payload, kid: kid)
    }

    static func registerAppleMusicSigner(using app: Application) throws {
        let privateKey = try String(contentsOfFile: app.directory.workingDirectory + "Secrets/" + "ES256_key.p8")

        let signer = JWTSigner.es256(key: try .private(pem: privateKey.bytes))

        app.jwt.signers.use(signer, kid: .appleMusic)
    }

    static func generateAppleMusicToken(using app: Application) throws -> String {
        let payload = try JWTGenerator.generatePayload(iss: Environment.amTeamId)

        return try JWTGenerator.generateAppleMusicToken(using: app, from: payload, kid: .appleMusic)
    }

}
