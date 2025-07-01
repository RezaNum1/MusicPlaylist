//
//  PlaylistView.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import SwiftUI

struct PlaylistView: View {
    @EnvironmentObject var viewModel: PlaylistViewModel
    @State var keyword: String = ""
    @State var isPlayed: Bool = false
    @State var sliderValue: Double = 0.0

    var body: some View {
        ZStack {
            VStack {
                HeaderSectionView(keyword: $keyword)
                    .padding(.bottom, 4)

                switch self.viewModel.viewState {
                case .empty:
                    EmptyView()
                case .loading:
                    ProgressView()
                case .error(let errorMessage):
                    Text(errorMessage)
                case .success:
                    PlaylistContentView(musics: viewModel.musics, activeMusic: viewModel.activeMusic) { selectedSong in
                        self.viewModel.onTapMusic(data: selectedSong)
                    }
                }

                Spacer()
            }

            MusicControlView(isPlayed: $isPlayed, sliderValue: $sliderValue,
                             playAndPauseAction: { isPlayed.toggle() },
                             nextAction: { print("Next") },
                             previousAction: { print("Previous") }
            )
            .frame(alignment: .bottom)
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}
