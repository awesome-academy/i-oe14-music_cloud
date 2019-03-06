//
//  BaseViewController.swift
//  MusicCloud
//
//  Created by thanh on 3/3/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit
import LNPopupController

class BaseViewController: UIViewController {
    var musicPlayer = MediaManager.getInstance()
    var playBarButton: UIBarButtonItem!
    var pauseBarButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        createObserver()
    }
    
    func createObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(avplayerDidFinish(_:)), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    func removeObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    deinit {
        removeObserver()
    }
}
//MARK: - End

extension BaseViewController {
    @objc func avplayerDidFinish(_ notification: Notification) {
        switch musicPlayer.playerMode {
        case .loopForOnce:
            musicPlayer.loopForOnce()
        case .normal:
            musicPlayer.next()
        case .shuffle:
            musicPlayer.shuffle()
        }
    }
    
    func configMiniPlayer() {
        guard let audioPlayer = musicPlayer.audioPlayer else { return }
        let track = musicPlayer.musicList[musicPlayer.index]
        popupItem.title = track.title
        popupItem.subtitle = track.user.username
        playBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Play.png"), style: .plain, target: self, action: #selector(playSong))
        pauseBarButton = UIBarButtonItem(image: #imageLiteral(resourceName: "Pause.png"), style: .plain, target: self, action: #selector(pauseSong))
        if audioPlayer.rate == 0 {
            popupItem.rightBarButtonItems = [playBarButton]
        } else {
            popupItem.rightBarButtonItems = [pauseBarButton]
        }
    }
    
    @objc func playSong() {
        musicPlayer.play()
        popupItem.rightBarButtonItems = [pauseBarButton]
    }
    
    @objc func pauseSong() {
        musicPlayer.pause()
        popupItem.rightBarButtonItems = [playBarButton]
    }
}
