//
//  MusicControlView.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import SwiftUI

struct MusicControlView: View {
    @Binding var isPlayed: Bool
    @Binding var sliderValue: Double
    let playAndPauseAction: () -> Void
    let nextAction: () -> Void
    let previousAction: () -> Void

    var body: some View {
        VStack {
            Spacer()

            VStack {
                topSection
                bottomSection
            }
            .frame(height: 120)
            .background(
                Color(red: 0.75, green: 0.75, blue: 0.75).opacity(0.1)
                    .background(.ultraThinMaterial)
            )
        }
    }

    var topSection: some View {
        HStack {
            Spacer()
            ButtonIconView(systemName: "backward.end.alt.fill", size: .init(width: 30, height: 20)) {
                previousAction()
            }

            Spacer()

            if isPlayed {
                ButtonIconView(systemName: "pause.fill", size: .init(width: 20, height: 25)) {
                    playAndPauseAction()
                }
            } else {
                ButtonIconView(systemName: "play.fill", size: .init(width: 20, height: 25)) {
                    playAndPauseAction()
                }
            }

            Spacer()

            ButtonIconView(systemName: "forward.end.alt.fill", size: .init(width: 30, height: 20)) {
                nextAction()
            }

            Spacer()
        }
    }

    var bottomSection: some View {
        Slider(value: $sliderValue, in: 0...10)
            .padding(.horizontal, 16)
            .padding(.bottom, 8)
    }
}
