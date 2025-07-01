//
//  ClientAPI.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import Foundation

protocol ClientAPIProtocol {
    func dispatch<R: Request>(_ request: R) async throws -> R.ReturnType
}
