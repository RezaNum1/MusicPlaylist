//
//  ErrorStateView.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 02/07/25.
//

import SwiftUI

struct ErrorStateView: View {
    let message: String
    let action: () -> Void

    var body: some View {
        VStack(spacing: 12){
            Spacer()

            Image(systemName: "gear.badge.xmark")
                .resizable()
                .foregroundColor(Color.gray.opacity(0.6))
                .frame(width: 200, height: 200)

            Text(message)
                .font(.system(size: 23))
                .fontWeight(.regular)
                .foregroundColor(Color.gray)
                .padding(.bottom, 24)

            Button(action: action) {
                Text("Refresh")
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(12) // Rounded corners
            }
            .padding(.horizontal)
            .padding(.bottom, 80)

            Spacer()
        }
    }
}
