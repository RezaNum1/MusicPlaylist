//
//  MusicRepository.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import Foundation

protocol MusicRepository {
    func getAllMusics() async throws -> [Music]
}
