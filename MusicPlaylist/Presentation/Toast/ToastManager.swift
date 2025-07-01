//
//  ToastManager.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 02/07/25.
//

import Foundation
import UIKit

class ToastManager: ObservableObject {
    static let shared = ToastManager()

    @Published var message: String = ""
    @Published var isShowing = false

    private init() {}

    func show(_ text: String, duration: TimeInterval = 3.0, haptic: UINotificationFeedbackGenerator.FeedbackType = .error) {
        message = text
        isShowing = true

        // Haptic feedback
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(haptic)

        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            self.isShowing = false
        }
    }
}
