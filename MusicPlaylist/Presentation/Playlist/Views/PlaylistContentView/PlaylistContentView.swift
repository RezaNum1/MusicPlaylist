//
//  PlaylistContentView.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import SwiftUI

struct PlaylistContentView: View {
    var musics: [Music]
    var activeMusic: Music?
    var onCellTappedAction: (Music) -> Void

    var body: some View {
        ScrollView(.vertical){
            VStack(alignment: .leading, spacing: 0) {
                ForEach(musics) { music in
                    PlaylistCellView(data: music, isActive: activeMusic == music)
                        .onTapGesture {
                            onCellTappedAction(music)
                        }
                }
            }
        }
        .frame(maxHeight: .infinity)
    }
}
