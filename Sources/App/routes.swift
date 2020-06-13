import Fluent
import JWT
import Vapor

func routes(_ app: Application) throws {

    try app.register(collection: TodoController())

    let signer = try JWTSigner.es256(key: .private(pem: Environment.amKey.bytes))
    app.jwt.signers.use(signer, kid: .appleMusic, isDefault: false)
    let payload = try JWTGenerator.generatePayload(kId: "", iss: "")
    let token = try app.jwt.signers.get(kid: .appleMusic)?.sign(payload) ?? ""
    let controller = AppleMusicSearchController(token: token)
    try app.register(collection: controller)
}
