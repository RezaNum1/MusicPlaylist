//
//  SearchTextField.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import SwiftUI

struct HeaderSectionView: View {
    @Binding var keyword: String

    var body: some View {
        ZStack {
            Color.gray.opacity(0.2)
            TextField("Search Artist", text: $keyword)
                .frame(height: 40)
                .frame(maxWidth: .infinity)
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 24)
        }
        .frame(height: 60)
    }
}
