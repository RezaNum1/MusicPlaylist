//
//  MusicRepositoryImpl.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import Foundation

class MusicRepositoryImpl: MusicRepository {
    let clientApi: ClientAPIProtocol

    init(clientApi: ClientAPIProtocol = ClientAPI()) {
        self.clientApi = clientApi
    }

    func getAllMusics() async throws -> [Music] {
        do {
            let response = try await clientApi.dispatch(MusicRequest())
            return response.data.map { $0.toModel }
        } catch {
            throw error
        }
    }
}
