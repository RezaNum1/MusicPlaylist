//
//  ToastManager_Tests.swift
//  MusicPlaylistTests
//
//  Created by Reza Harris on 02/07/25.
//

@testable import MusicPlaylist
import XCTest

final class ToastManager_Tests: XCTestCase {

    var toastManager: ToastManager!

    override func setUp() {
        super.setUp()
        toastManager = ToastManager.shared
    }

    override func tearDown() {
        toastManager.isShowing = false
        toastManager.message = ""
        super.tearDown()
    }

    func test_show_setsMessageAndIsShowing() {
        toastManager.show("Test message")

        XCTAssertEqual(toastManager.message, "Test message")
        XCTAssertTrue(toastManager.isShowing)
    }

    func test_show_hidesAfterDuration() {
        let expectation = expectation(description: "Toast should disappear")

        toastManager.show("Hello", duration: 1.0)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            XCTAssertFalse(self.toastManager.isShowing)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func test_show_overwritesPreviousToast() {
        toastManager.show("First Toast", duration: 3.0)
        toastManager.show("Second Toast", duration: 3.0)

        XCTAssertEqual(toastManager.message, "Second Toast")
    }

}
