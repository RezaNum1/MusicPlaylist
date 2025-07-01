//
//  ToastView.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 02/07/25.
//

import SwiftUI

struct ToastView: View {
    @Binding var isShowing: Bool
    let message: String

    var body: some View {
        VStack {
            Spacer()
            toastText
                .padding(.bottom, 40)
                .animation(.easeInOut, value: isShowing)
        }
        .transition(.opacity)

    }

    var toastText: some View {
        Text(message)
            .padding()
            .background(Color.black.opacity(0.85))
            .foregroundColor(.white)
            .cornerRadius(10)
            .padding(.horizontal)
            .transition(.move(edge: .bottom).combined(with: .opacity))
    }
}
