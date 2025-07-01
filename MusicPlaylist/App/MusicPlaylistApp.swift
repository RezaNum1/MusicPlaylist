//
//  MusicPlaylistApp.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import SwiftUI

@main
struct MusicPlaylistApp: App {
    @StateObject var playlistVM: PlaylistView.PlaylistViewModel = .init()
    @StateObject var audioPlayerVM: AudioPlayerViewModel = .init()

    var body: some Scene {
        WindowGroup {
            PlaylistView()
                .environmentObject(self.playlistVM)
                .environmentObject(self.audioPlayerVM)
        }
    }
}
