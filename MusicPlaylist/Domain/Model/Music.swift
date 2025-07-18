//
//  Music.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import Foundation

struct Music: Equatable, Identifiable {
    var id: String
    var title: String
    var artistName: String
    var albumName: String
    var imageURL: String
    var audioURL: String
}
