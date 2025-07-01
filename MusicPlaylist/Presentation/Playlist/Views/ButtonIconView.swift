//
//  ButtonIconView.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import SwiftUI

struct ButtonIconView: View {
    let systemName: String
    let size: CGSize
    var color: Color = Color.black
    let onTapAction: () -> Void

    var body: some View {
        Button {
            onTapAction()
        } label: {
            Image(systemName: systemName)
                .resizable()
                .foregroundColor(color)
                .frame(width: size.width, height: size.height)
        }
    }
}
