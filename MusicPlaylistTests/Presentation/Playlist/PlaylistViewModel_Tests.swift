//
//  PlaylistViewModel_Tests.swift
//  MusicPlaylistTests
//
//  Created by Reza Harris on 02/07/25.
//

@testable import MusicPlaylist
import XCTest

@MainActor
final class PlaylistViewModel_Tests: XCTestCase {

    var viewModel: PlaylistView.PlaylistViewModel!

    override func setUpWithError() throws {
        super.setUp()
        guard let responseURL = Bundle(for: type(of: self)).url(forResource: "MusicResponse_200", withExtension: "json"), let responseData = try? Data(contentsOf: responseURL) else {
            XCTFail("Failed to load the mock JSON response")
            return
        }

        guard let response = try? JSONDecoder().decode(MusicResponse.self, from: responseData) else {
            throw NetworkRequestError.decodingError
        }

        let repository = MusicRepositoryMock(error: nil, response: response)

        viewModel = PlaylistView.PlaylistViewModel(repository: repository)
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        viewModel = nil
        super.tearDown()
    }

    func test_getAllMusic_shouldBeSuccess() async throws {
        await viewModel.getMusics()
        XCTAssertEqual(viewModel.musics.count, 10)
        XCTAssertEqual(viewModel.viewState, .success)
    }

    func test_getAllMusic_shouldBeInvalidRequest() async throws {
        let repository = MusicRepositoryMock(error: NetworkRequestError.invalidRequest)
        let viewModel = PlaylistView.PlaylistViewModel(repository: repository)

        await viewModel.getMusics()

        switch viewModel.viewState {
        case .error(let message):
            XCTAssertEqual(message, "Bad Request – The server couldn't understand the request.")
        default: XCTFail("Failed: Test Should be throw invalid request error")
        }
    }

    func test_getAllMusic_shouldBeDecodingError() async throws {
        let repository = MusicRepositoryMock(error: NetworkRequestError.decodingError)
        let viewModel = PlaylistView.PlaylistViewModel(repository: repository)

        await viewModel.getMusics()

        switch viewModel.viewState {
        case .error(let message):
            XCTAssertEqual(message, "Something went wrong while processing the data. Please try again later.")
        default: XCTFail("Failed: Test Should be throw invalid request error")
        }
    }

    func test_getAllMusic_shouldBeMaintenance() async throws {
        let repository = MusicRepositoryMock(error: NetworkRequestError.maintenance)
        let viewModel = PlaylistView.PlaylistViewModel(repository: repository)

        await viewModel.getMusics()

        switch viewModel.viewState {
        case .error(let message):
            XCTAssertEqual(message, "Server Error – Please try again later.")
        default: XCTFail("Failed: Test Should be throw invalid request error")
        }
    }

    func test_getAllMusic_shouldBeUnknownError() async throws {
        let error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Something went wrong"])
        let repository = MusicRepositoryMock(error: error)
        let viewModel = PlaylistView.PlaylistViewModel(repository: repository)

        await viewModel.getMusics()

        switch viewModel.viewState {
        case .error(let message):
            XCTAssertEqual(message, "Something went wrong while processing the data. Please try again later.")
        default: XCTFail("Failed: Test Should be throw invalid request error")
        }
    }

    func test_onTapMusic_shouldBeSuccess() async throws {
        await viewModel.getMusics()
        viewModel.onTapMusic(data: viewModel.musics[0])

        XCTAssertNotNil(viewModel.activeMusic)
    }

    func test_searchMusic_shouldBeSuccess() async throws {
        await viewModel.getMusics()
        viewModel.searchMusic(keyword: "lady")

        XCTAssertEqual(viewModel.searchResult.count, 2)
    }

    func test_searchMusic_withEmptyKeyword_shouldBeSuccess() async throws {
        await viewModel.getMusics()
        viewModel.searchMusic(keyword: "")

        XCTAssertEqual(viewModel.searchResult.count, 10)
    }
}

