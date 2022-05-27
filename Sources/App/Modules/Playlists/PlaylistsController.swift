//
//  PlaylistsController.swift
//  
//
//  Created by Max Baumbach on 19/06/2020.
//

import MusicCore
import Vapor

struct PlaylistsController {

    private let token: String

    init(token: String) {
        self.token = token
    }
 
    // MARK: - View

    func playlistsView(req: Request) async throws -> Response {
        let userToken = try JWTGenerator.fetchUserMusicToken(app: req.application)
        let headers: HTTPHeaders = HTTPHeaders([
                ("Authorization", "Bearer \(token)"),
                ("media-user-token", userToken)
            ])
        let uri = URI(string: MusicEndpoint.playlists.playlists)
        let response = try await req.client.get(uri, headers: headers)
        let playlists = try response.content.decode(ResponseRoot.self)
        dump(playlists)

        let newPlays = playlists.data?.compactMap({ resource in
            return Playlist(title: resource.attributes?.name ?? "", description: "", appleMusicId: resource.id)
        }) ?? []

        let context = PlaylistsContext(count: newPlays.count, playlists: newPlays)
        return req.templateRenderer.renderHtml(PlaylistsTemplate(context: context))
    }

}
