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
        @Published var musics: [Music] = [] {
            didSet {
                self.searchResult = musics
            }
        }
        
        var repository: MusicRepository
        @Published var viewState: ViewState = .loading
        @Published private(set) var activeMusic: Music? = nil
        @Published var searchResult: [Music] = []
        @Published var sliderValue = 0.0

        init(musics: [Music] = [], repository: MusicRepository = MusicRepositoryImpl()) {
            self.musics = musics
            self.repository = repository
            Task {
                await self.getMusics()
            }
        }

        func getMusics() async {
            do {
                self.musics = try await self.repository.getAllMusics()
                print(musics.count)
                self.viewState = .success
            } catch {
                self.errorHandler(error: error)
            }
        }

        func onTapMusic(data: Music) {
            self.activeMusic = data
        }

        private func errorHandler(error: Error) {
            if let error = error as? NetworkRequestError {
                switch error {
                case .invalidRequest:
                    viewState = .error("Bad Request – The server couldn't understand the request.")
                case .decodingError:
                    viewState = .error("Something went wrong while processing the data. Please try again later.")
                default:
                    viewState = .error("Server Error – Please try again later.")
                }
            } else {
                viewState = .error("Something went wrong while processing the data. Please try again later.")
            }
        }

        func searchMusic(keyword: String) {
            searchResult = keyword == "" ? musics : musics.filter { $0.artistName.lowercased().contains(keyword) }
        }
    }
}
