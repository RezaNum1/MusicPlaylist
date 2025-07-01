//
//  Music.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import Foundation

struct MusicRequest: Request {
    typealias ReturnType = MusicResponse
    var url: String = "https://api.deezer.com/search?q=b"
}
