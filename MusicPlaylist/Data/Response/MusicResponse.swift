//
//  MusicResponse.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import Foundation


struct MusicResponse: Codable {
    var data: [DetailMusic]

    struct DetailMusic: Codable {
        var id: Int?
        var title: String?
        var artist: Artist?
        var album: Album?
        var audioURL: String?

        var imageURL: String? {
            if let mediumSize = self.album?.coverMedium {
                return mediumSize
            }

            if let bigSize = self.album?.coverBig {
                return bigSize
            }

            return nil
        }

        enum CodingKeys: String, CodingKey {
            case id
            case title
            case artist
            case album
            case audioURL = "preview"
        }


        struct Artist: Codable {
            var name: String?
            enum CodingKeys: String, CodingKey {
                case name
            }

        }

        struct Album: Codable {
            var title: String?
            var coverMedium: String?
            var coverBig: String?

            enum CodingKeys: String, CodingKey {
                case title
                case coverMedium = "cover_medium"
                case coverBig = "cover_big"
            }
        }

        var toModel: Music {
            return Music(
                id: String(self.id ?? 0),
                title: self.title ?? "",
                artistName: self.artist?.name ?? "",
                albumName: self.album?.title ?? "",
                imageURL: self.imageURL ?? ""
            )
        }
    }
}
