//
//  MusicRepository_Tests.swift
//  MusicPlaylistTests
//
//  Created by Reza Harris on 02/07/25.
//

@testable import MusicPlaylist
import XCTest

final class MusicRepository_Tests: XCTestCase {
    func test_getAllMusic_200Response_shouldBeSuccess() async throws {
        guard let responseURL = Bundle(for: type(of: self)).url(forResource: "MusicResponse_200", withExtension: "json"), let responseData = try? Data(contentsOf: responseURL) else {
            XCTFail("Failed to load the mock JSON response")
            return
        }

        let mockClientApi = MockClientAPI(shouldSuccess: true, mockData: responseData)

        let musicRepository = MusicRepositoryImpl(clientApi: mockClientApi)

        do {
            let result = try await musicRepository.getAllMusics()
            XCTAssertEqual(result.count, 10)
        } catch {
            XCTFail("Unexpected error: \(error))")
        }
    }

    func test_getAllMusic_500Response_shouldBeFailed() async throws {
        guard let responseURL = Bundle(for: type(of: self)).url(forResource: "MusicResponse_200", withExtension: "json"), let responseData = try? Data(contentsOf: responseURL) else {
            XCTFail("Failed to load the mock JSON response")
            return
        }

        let mockClientApi = MockClientAPI(shouldSuccess: false, mockData: responseData)

        let musicRepository = MusicRepositoryImpl(clientApi: mockClientApi)

        do {
            let result = try await musicRepository.getAllMusics()
            XCTFail("Failed: Test Should be throw error maintenance")
        } catch {
            XCTAssertNotNil(error)
        }
    }
}
