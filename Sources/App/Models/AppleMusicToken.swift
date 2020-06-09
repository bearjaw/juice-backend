//
//  AppleMusicToken.swift
//  
//
//  Created by Max Baumbach on 09/06/2020.
//

import JWT

struct AppleMusicToken: JWTPayload {

    let iss: String

    let iat: TimeInterval

    let exp: TimeInterval

    func verify(using signer: JWTSigner) throws {

    }
    
}

