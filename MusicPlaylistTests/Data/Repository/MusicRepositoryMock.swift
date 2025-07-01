//
//  MusicRepositoryMock.swift
//  MusicPlaylistTests
//
//  Created by Reza Harris on 02/07/25.
//

@testable import MusicPlaylist
import Foundation

struct MusicRepositoryMock: MusicRepository {
    init(error: Error? = nil, response: MusicResponse? = nil) {
        self.error = error
        self.response = response
    }

    var error: Error?
    var response: MusicResponse?

    func getAllMusics() async throws -> [Music] {
        if error == nil {
            return response?.data.map { $0.toModel } ?? []
        } else {
            throw error ?? NetworkRequestError.invalidRequest
        }
    }
}
