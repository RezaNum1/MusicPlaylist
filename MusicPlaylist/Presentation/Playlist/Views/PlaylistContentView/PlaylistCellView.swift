//
//  PlaylistCellView.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import SwiftUI

struct PlaylistCellView: View {
    var data: Music
    var isActive: Bool

    var body: some View {
        ZStack {
            content
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(isActive ? Color.gray.opacity(0.2) : Color.white)
    }

    var content: some View {
        VStack(alignment: .leading) {
            HStack(spacing: 16){
                HStack(alignment: .top, spacing: 16){
                    image
                    VStack(alignment: .leading, spacing: 2){
                        titleText
                        artistText
                        albumText
                    }
                }

                Spacer()

                if isActive {
                    TinyWaveformView()
                }
            }
            .padding(.bottom, 8)

            divider
        }
        .padding(.top, 8)
        .padding(.horizontal, 24)
    }

    var image: some View {
        ZStack {
            if let url = URL(string: data.imageURL) {
                AsyncImage(url: url) {
                    $0.image?.resizable()
                }
                    .clipShape(RoundedRectangle(cornerRadius: 6))
                    .frame(width: 80, height: 80)
            } else {
                ZStack {
                    Image(systemName: "music.note")
                        .resizable()
                }
                .frame(width: 80, height: 80)
            }
        }
    }

    var titleText: some View {
        Text(data.title)
            .fontWeight(.semibold)
            .font(.system(size: 18))
    }

    var artistText: some View {
        Text(data.artistName)
            .fontWeight(.regular)
            .font(.system(size: 16))
    }

    var albumText: some View {
        Text(data.albumName)
            .fontWeight(.thin)
            .font(.system(size: 14))
            .foregroundColor(Color.gray.opacity(0.7))
    }

    var divider: some View {
        Rectangle()
            .fill(Color.gray.opacity(0.5))
            .frame(height: 1.5)
    }
}
