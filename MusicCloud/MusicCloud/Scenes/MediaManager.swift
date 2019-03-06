//
//  MediaManager.swift
//  MusicCloud
//
//  Created by thanh on 3/2/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation
import AVFoundation
import AVKit
import MediaPlayer

private protocol MediaManagerProtocol {
    func prepare(index: Int) -> URL
    func play(url: URL, track: Track)
    func pause()
    func changeTrack(increase: Int)
    func next()
    func previous()
    func shuffle()
    func stop()
    func loopForOnce()
}

enum PlayMode {
    case loopForOnce
    case shuffle
    case normal
}

class MediaManager: NSObject {
    private static let shareInstance = MediaManager()
    var audioPlayer: AVPlayer?
    var index = 0
    var musicList = [Track]()
    var playerMode = PlayMode.normal
    
    static func getInstance() -> MediaManager {
        return shareInstance
    }
    
    func prepare(index: Int) -> URL {
        let track = musicList[index]
        switch track.type {
        case .offlineTrack:
            return track.offlineURL ?? URL(string: "")!
        case .onlineTrack:
            let url = track.uri + "/stream" + "?client_id=" + APIKey.APIKey
            return URL(string: url) ?? URL(string: "")!
        }
    }
    
    func play(url: URL) {
        let playerItem = AVPlayerItem(url: url)
        audioPlayer = AVPlayer(playerItem: playerItem)
        audioPlayer?.play()
    }
    
    func play() {
        audioPlayer?.play()
    }
    
    func pause() {
        audioPlayer?.pause()
    }
    
    func stop() {
        audioPlayer = AVPlayer()
    }
    
    func shuffle() {
        let range = CountableRange<Int>(uncheckedBounds: (lower: 0, upper: musicList.count))
        index = Int.random(in: range)
        let url = prepare(index: index)
        play(url: url)
    }
    
    func loopForOnce() {
        changeTrack(increase: 0)
    }
    
    func changeTrack(increase: Int) {
        index = index + increase
        if index >= musicList.count {
            index = 0
        } else if index < 0 {
            index = musicList.count - 1
        }
        let url = prepare(index: index)
        play(url: url)
    }
    
    func next()  {
        changeTrack(increase: 1)
    }
    
    func previous() {
        changeTrack(increase: -1)
    }
}
