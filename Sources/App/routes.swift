import Fluent
import JWT
import Vapor

func routes(_ app: Application) throws {

    try app.register(collection: TodoController())
    let privateKey = try String(contentsOfFile: app.directory.workingDirectory + "ES256_key.p8")
    let key = try ECDSAKey.private(pem: privateKey.bytes)
    let signer = JWTSigner.es256(key: key)
    app.jwt.signers.use(signer, kid: .appleMusic, isDefault: false)
    let payload = try JWTGenerator.generatePayload(kId: Environment.amJWKId, iss: Environment.amTeamId)
    let token = try app.jwt.signers.get(kid: .appleMusic)?.sign(payload) ?? ""
    let controller = AppleMusicSearchController(token: token)
    try app.register(collection: controller)
}
