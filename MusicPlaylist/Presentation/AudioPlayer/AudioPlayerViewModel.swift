//
//  AudioPlayerViewModel.swift
//  MusicPlaylist
//
//  Created by Reza Harris on 01/07/25.
//

import Foundation
import AVFoundation

class AudioPlayerViewModel: ObservableObject {
    @Published var currentTime: Double = 0
    @Published var duration: Double = 0
    @Published var isPlaying = false
    @Published var activeMusic: Music? = nil

    private var timeObserver: Any?
    private var player: AVPlayer?
    private var playerItemObservation: NSKeyValueObservation?

    func loadAudio(data: Music) {
        self.activeMusic = data

        if let existingPlayer = player {
               existingPlayer.pause()
               existingPlayer.replaceCurrentItem(with: nil)
           }

        self.setupAudioSession()

        guard let url = URL(string: data.audioURL) else { return }
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)

        NotificationCenter.default.addObserver(
            self,
            selector: #selector(playerDidFinishPlaying),
            name: .AVPlayerItemDidPlayToEndTime,
            object: playerItem
        )

        playerItemObservation = playerItem.observe(\.status, options: [.new]) { [weak self] item, _ in
            if item.status == .readyToPlay {
                self?.player?.play()
                self?.isPlaying = true
            }
        }

        setupTimeObserver()
    }

    func play() {
        player?.play()
        isPlaying = true
    }

    func pause() {
        player?.pause()
        isPlaying = false
    }

    func togglePlayPause() {
        isPlaying ? pause() : play()
    }

    func seek(to time: Double) {
        player?.seek(to: CMTime(seconds: time, preferredTimescale: 1))
    }

    func next(data: [Music]) {
        if let currentIndex = data.firstIndex(where: { $0.id == activeMusic?.id }), (currentIndex + 1) < data.count {
            self.loadAudio(data: data[currentIndex + 1])
        }
    }

    func previous(data: [Music]) {
        if let currentIndex = data.firstIndex(where: { $0.id == activeMusic?.id }), (currentIndex - 1) >= 0 {
            self.loadAudio(data: data[currentIndex - 1])
        }
    }


    @objc private func playerDidFinishPlaying() {
        isPlaying = false
        currentTime = 0
        seek(to: 0)
    }

    private func setupAudioSession() {
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to set AVAudioSession: \(error)")
            ToastManager.shared.show("Failed to set audio session.")
        }
    }

    private func setupTimeObserver() {
        guard let player = player else { return }

        let interval = CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        timeObserver = player.addPeriodicTimeObserver(forInterval: interval, queue: .main) { [weak self] time in
            guard let self = self else { return }
            self.currentTime = time.seconds
            if let duration = player.currentItem?.duration.seconds, duration.isFinite {
                self.duration = duration
            }
        }
    }

    deinit {
        if let observer = timeObserver {
            player?.removeTimeObserver(observer)
        }
    }
}
