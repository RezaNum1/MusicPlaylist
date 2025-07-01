//
//  WaveformView.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import SwiftUI

struct TinyWaveformView: View {
    @State private var barHeights: [CGFloat] = [6, 10, 20, 8, 25, 18, 4, 2]

    var body: some View {
        HStack(spacing: 2) {
            ForEach(0..<barHeights.count, id: \.self) { index in
                Capsule()
                    .fill(.gray.opacity(0.9))
                    .frame(width: 3, height: barHeights[index])
                    .animation(.easeInOut(duration: 0.3), value: barHeights[index])
            }
        }
        .frame(width: 30, height: 20)
        .onAppear {
            startWaveAnimation()
        }
    }

    func startWaveAnimation() {
        Timer.scheduledTimer(withTimeInterval: 0.3, repeats: true) { _ in
            for i in barHeights.indices {
                barHeights[i] = CGFloat.random(in: 1...25)
            }
        }
    }
}
