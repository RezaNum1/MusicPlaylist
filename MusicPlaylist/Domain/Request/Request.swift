//
//  Request.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import Foundation

protocol Request {
    associatedtype ReturnType: Codable
    var url: String { get }
}
