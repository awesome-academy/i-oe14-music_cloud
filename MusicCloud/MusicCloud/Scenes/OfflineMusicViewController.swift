//
//  OfflineMusicViewController.swift
//  MusicCloud
//
//  Created by thanh on 2/22/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit
import Reusable
import Then
import MediaPlayer

final class OfflineMusicViewController: BaseViewController {
    @IBOutlet private weak var tableView: UITableView!
    let trackCounting = MPMediaQuery.songs().collections?.count
    var offlineTracks = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getLocalMusic()
    }
    
    private func setupViews() {
        navigationItem.title = NavigationConstant.offlineMusicNavItemTitle
        tableView.then {
            $0.dataSource = self
            $0.delegate = self
            $0.register(cellType: OfflineMusicCell.self)
            $0.register(cellType: TrackCountingCell.self)
            if trackCounting == 0 {
                $0.separatorStyle = .none
                $0.backgroundColor = .clear
            }
        }
    }
    
    private func getLocalMusic() {
        let secondQuery = MPMediaQuery.songs()
        guard let result = secondQuery.collections else { return }
        for item in result {
            let track = Track()
            guard let representativeItem = item.representativeItem else { return }
            track.initFromMediaItem(representativeItem)
            offlineTracks.append(track)
            tableView.reloadData()
        }
    }
}

extension OfflineMusicViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if trackCounting == nil || trackCounting == 0 {
            return 0
        } else {
            return offlineTracks.count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(for: indexPath) as TrackCountingCell
            cell.delegate = self
            cell.selectionStyle = .none
            if let count = trackCounting {
                cell.updateCell(count: count)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(for: indexPath) as OfflineMusicCell
            if offlineTracks.count > 0 {
                cell.updateCell(track: offlineTracks[indexPath.row - 1])
            }
            cell.selectionStyle = .none
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 {
            musicPlayer.musicList = offlineTracks
            musicPlayer.index = indexPath.row - 1
            musicPlayer.stop()
            let streamUrl = musicPlayer.prepare(index: musicPlayer.index)
            musicPlayer.play(url: streamUrl)
            let player = PlayerViewController.instantiate()
            presentPopupBar(player)
        }
    }
}

extension OfflineMusicViewController: ShuffleCellDelegate {
    func didTapPlay() {
        musicPlayer.playerMode = .normal
        musicPlayer.musicList = offlineTracks
        musicPlayer.index = 0
        musicPlayer.stop()
        let url = musicPlayer.prepare(index: 0)
        musicPlayer.play(url: url)
        let player = PlayerViewController.instantiate()
        presentPopupBar(player)
    }
    
    func didTapShuffle() {
        musicPlayer.playerMode = .shuffle
        musicPlayer.musicList = offlineTracks
        musicPlayer.stop()
        musicPlayer.shuffle()
        let player = PlayerViewController.instantiate()
        presentPopupBar(player)
    }
}

extension OfflineMusicViewController: PresentDelegate {
    func presentPopupBar(_ viewController: BaseViewController) {
        tabBarController?.popupBar.marqueeScrollEnabled = true
        tabBarController?.presentPopupBar(withContentViewController: viewController, animated: true, completion: nil)
        viewController.configMiniPlayer()
    }
}

extension OfflineMusicViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
