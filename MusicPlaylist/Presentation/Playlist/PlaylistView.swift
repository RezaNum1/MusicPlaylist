//
//  PlaylistView.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import SwiftUI

struct PlaylistView: View {
    @EnvironmentObject var viewModel: PlaylistViewModel
    @EnvironmentObject var audioPlayerVM: AudioPlayerViewModel
    @StateObject private var toast = ToastManager.shared
    @State var keyword: String = ""

    var body: some View {
        ZStack {
            VStack {
                HeaderSectionView(keyword: $keyword)
                    .padding(.bottom, 4)

                switch self.viewModel.viewState {
                case .loading:
                    ProgressView()

                case .error(let errorMessage):
                    ErrorStateView(message: errorMessage, action: { Task { await viewModel.getMusics() } })

                case .success:
                    PlaylistContentView(musics: viewModel.searchResult, activeMusic: audioPlayerVM.activeMusic) { selectedSong in
                        self.audioPlayerVM.loadAudio(data: selectedSong)
                    }
                }

                Spacer()
            }

            // Music Control
            if audioPlayerVM.activeMusic != nil {
                MusicControlView(isPlayed: $audioPlayerVM.isPlaying,
                                 sliderValue: $audioPlayerVM.currentTime,
                                 durationValue: $audioPlayerVM.duration,
                                 isNextDisabled: audioPlayerVM.activeMusic == viewModel.musics.last,
                                 isPreviousDisabled: audioPlayerVM.activeMusic == viewModel.musics.first,
                                 playAndPauseAction: { audioPlayerVM.togglePlayPause() },
                                 nextAction: { audioPlayerVM.next(data: self.viewModel.musics) },
                                 previousAction: { audioPlayerVM.previous(data: self.viewModel.musics) },
                                 seekToAction: { self.audioPlayerVM.seek(to: audioPlayerVM.currentTime) }
                )
                .frame(alignment: .bottom)
            }

            // Toast For Error
            if toast.isShowing {
                ToastView(isShowing: $toast.isShowing, message: toast.message)
            }

        }
        .onChange(of: keyword) { _, newValue in
            self.viewModel.searchMusic(keyword: newValue)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
