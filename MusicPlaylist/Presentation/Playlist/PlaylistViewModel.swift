//
//  PlaylistViewModel.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import SwiftUI

extension PlaylistView {
    @MainActor
    class PlaylistViewModel: ObservableObject {
        @Published var musics: [Music] = []
        var repository: MusicRepository
        @Published var viewState: ViewState = .loading
        @Published private(set) var activeMusic: Music? = nil

        init(musics: [Music] = [], repository: MusicRepository = MusicRepositoryImpl()) {
            self.musics = musics
            self.repository = repository
            self.getMusics()
        }

        func getMusics() {
            Task {
                do {
                    self.musics = try await self.repository.getAllMusics()
                    self.viewState = .success
                } catch {
                    self.errorHandler(error: error)
                }
            }
        }

        func onTapMusic(data: Music) {
            self.activeMusic = data
        }

        private func errorHandler(error: Error) {
            if let error = error as? NetworkRequestError {
                switch error {
                case .invalidRequest:
                    viewState = .error("Invalid Request")
                }
            }

            viewState = .error("")
        }
    }
}
