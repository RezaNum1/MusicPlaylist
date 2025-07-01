//
//  MockClientAPI.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 02/07/25.
//

@testable import MusicPlaylist
import Foundation

class MockClientAPI: ClientAPIProtocol {
    init(shouldSuccess: Bool, mockData: Data) {
        self.shouldSucceed = shouldSuccess
        self.mockData = mockData
    }

    var shouldSucceed: Bool
    var mockData: Data

    func dispatch<R>(_ request: R) async throws -> R.ReturnType where R : Request {
        if self.shouldSucceed {
            guard let response = try? JSONDecoder().decode(R.ReturnType.self, from: mockData) else {
                throw NetworkRequestError.decodingError
            }

            return response
        } else {
            throw NetworkRequestError.maintenance
        }
    }
}
