//
//  AudioPlayerViewModel_Tests.swift
//  MusicPlaylistTests
//
//  Created by Reza Harris on 02/07/25.
//

@testable import MusicPlaylist
import XCTest

final class AudioPlayerViewModel_Tests: XCTestCase {

    var viewModel: AudioPlayerViewModel!
    var mockMusic: Music!
    var mockMusics: [Music]!

    override func setUp() {
        super.setUp()
        viewModel = AudioPlayerViewModel()

        guard let responseURL = Bundle(for: type(of: self)).url(forResource: "MusicResponse_200", withExtension: "json"), let responseData = try? Data(contentsOf: responseURL) else {
            XCTFail("Failed to load the mock JSON response")
            return
        }

        guard let response = try? JSONDecoder().decode(MusicResponse.self, from: responseData) else {
            XCTFail("Failed: Decoding Error")
            return
        }

        mockMusics = response.data.map { $0.toModel }
        mockMusic = mockMusics[0]
    }

    override func tearDown() {
        viewModel = nil
        mockMusic = nil
        mockMusics = nil
        super.tearDown()
    }

    func test_loadAudio_setsActiveMusic() {
        viewModel.loadAudio(data: mockMusic)
        XCTAssertEqual(viewModel.activeMusic?.id, mockMusic.id)
    }

    func test_play_setsIsPlayingTrue() {
        viewModel.play()
        XCTAssertTrue(viewModel.isPlaying)
    }

    func test_pause_setsIsPlayingFalse() {
        viewModel.pause()
        XCTAssertFalse(viewModel.isPlaying)
    }

    func test_togglePlayPause_worksCorrectly() {
        viewModel.isPlaying = false
        viewModel.togglePlayPause()
        XCTAssertTrue(viewModel.isPlaying)

        viewModel.togglePlayPause()
        XCTAssertFalse(viewModel.isPlaying)
    }

    func test_next_playsNextMusic() {
        viewModel.loadAudio(data: mockMusics[0])
        viewModel.next(data: mockMusics)
        XCTAssertEqual(viewModel.activeMusic?.id, "2801558052")
    }

    func test_previous_playsPreviousMusic() {
        viewModel.loadAudio(data: mockMusics[1])
        viewModel.previous(data: mockMusics)
        XCTAssertEqual(viewModel.activeMusic?.id, "2947516331")
    }
}
