//
//  MiniPlayerViewController.swift
//  MusicCloud
//
//  Created by thanh on 3/3/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit
import Reusable
import AVFoundation
import AVKit
import MSPeekCollectionViewDelegateImplementation
import MarqueeLabel
import LNPopupController
import Then

struct CollectionViewConstant {
    static let cellSpacing = 0
    static let cellPeekWidth = 0
}

class PlayerViewController: BaseViewController {
    @IBOutlet private weak var titleLabel: MarqueeLabel!
    @IBOutlet private weak var artistLabel: MarqueeLabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var slider: UISlider!
    @IBOutlet private weak var currentTimeLabel: UILabel!
    @IBOutlet private weak var remainTimeLabel: UILabel!
    @IBOutlet private weak var loopButton: UIButton!
    @IBOutlet private weak var playButton: UIButton!
    
    private var timer = Timer()
    private var peekDelegate = MSPeekCollectionViewDelegateImplementation(cellSpacing: CGFloat(CollectionViewConstant.cellSpacing),
                                                                  cellPeekWidth: CGFloat(CollectionViewConstant.cellPeekWidth))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configCollectionView()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        scrollToActiveTrack()
        configView()
        configSlider()
    }
    
    private func configView() {
        guard let audioPlayer = musicPlayer.audioPlayer, let item = audioPlayer.currentItem else {
            titleLabel.text = ""
            artistLabel.text = ""
            currentTimeLabel.text = "--:--"
            remainTimeLabel.text = "--:--"
            playButton.setImage(UIImage(named: "Play"), for: .normal)
            return
        }
        titleLabel.text = musicPlayer.musicList[musicPlayer.index].title
        artistLabel.text = musicPlayer.musicList[musicPlayer.index].user.username
        let currentTime = Double(CMTimeGetSeconds(audioPlayer.currentTime()))
        let duration = Double(CMTimeGetSeconds((item.asset.duration)))
        slider.value = Float(currentTime / duration)
        currentTimeLabel.text = currentTime.timeToString()
        remainTimeLabel.text = (duration - currentTime).timeToString()
        if audioPlayer.rate == 0 {
            playButton.setImage(#imageLiteral(resourceName: "Play.png"), for: .normal)
        } else {
            playButton.setImage(#imageLiteral(resourceName: "Pause.png"), for: .normal)
        }
    }
    
    private func configCollectionView() {
        peekDelegate.delegate = self
        collectionView.then {
            $0.configureForPeekingDelegate()
            $0.delegate = peekDelegate
            $0.dataSource = self
            $0.register(cellType: TrackCollectionCell.self)
        }
    }
    
    @objc func onSliderValChanged(slider: UISlider, event: UIEvent) {
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                timer.invalidate()
            case .moved:
                break
            case .ended:
                timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateSlider), userInfo: nil, repeats: true)
            default:
                break
            }
        }
    }
    
    private func configSlider() {
        slider.value = 0.0
        slider.isContinuous = false
        slider.addTarget(self, action: #selector(onSliderValChanged(slider:event:)), for: .valueChanged)
        configView()
    }
    
    private func scrollToActiveTrack() {
        let nextItemOffset = peekDelegate.scrollView(collectionView, contentOffsetForItemAtIndex: musicPlayer.index)
        collectionView.setContentOffset(CGPoint(x: nextItemOffset, y: 0), animated: false)
        updateViewWhenChangeTrack(musicPlayer.index)
    }
    
    private func updateViewWhenChangeTrack(_ index: Int) {
        configView()
        configMiniPlayer()
    }
    
    @objc func updateSlider() {
        configView()
    }
    
    @IBAction func optionBtn(_ sender: Any) {
        // MARK: - To Do
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        if sender.value == 1 {
            switch musicPlayer.playerMode {
            case .normal:
                musicPlayer.next()
            case .loopForOnce:
                musicPlayer.loopForOnce()
            case .shuffle:
                musicPlayer.shuffle()
            }
            scrollToActiveTrack()
        } else {
            musicPlayer.pause()
            guard let audioPlayer = musicPlayer.audioPlayer, let item = audioPlayer.currentItem else { return }
            let duration = Double(CMTimeGetSeconds((item.asset.duration)))
            let currentTime = duration * Double(slider.value)
            audioPlayer.seek(to: CMTime(seconds: currentTime, preferredTimescale: 1000000))
            currentTimeLabel.text = currentTime.timeToString()
            remainTimeLabel.text = (duration - currentTime).timeToString()
            audioPlayer.play()
        }
    }
    
    @IBAction func playmodeBtn(_ sender: Any) {
        switch musicPlayer.playerMode {
        case .loopForOnce:
            musicPlayer.playerMode = .normal
            loopButton.setImage(#imageLiteral(resourceName: "loopForOnce.png"), for: .normal)
        case .normal:
            musicPlayer.playerMode = .shuffle
            loopButton.setImage(#imageLiteral(resourceName: "normal.png"), for: .normal)
        case .shuffle:
            musicPlayer.playerMode = .loopForOnce
            loopButton.setImage(#imageLiteral(resourceName: "ShuffleBtn.png"), for: .normal)
        }
    }
    
    @IBAction func previousBtn(_ sender: Any) {
        musicPlayer.previous()
        scrollToActiveTrack()
    }
    
    @IBAction func playBtn(_ sender: Any) {
        if musicPlayer.audioPlayer?.rate == 0 {
            musicPlayer.play()
            playButton.setImage(#imageLiteral(resourceName: "Pause.png"), for: .normal)
        } else {
            musicPlayer.pause()
            playButton.setImage(#imageLiteral(resourceName: "Play.png"), for: .normal)
        }
    }
    
    @IBAction func nextBtn(_ sender: Any) {
        switch musicPlayer.playerMode {
        case .normal:
            musicPlayer.next()
        case .loopForOnce:
            musicPlayer.loopForOnce()
        case .shuffle:
            musicPlayer.shuffle()
        }
        scrollToActiveTrack()
    }
    
    @IBAction func playlistBtn(_ sender: Any) {
        let nowPlayingList = NowPlayingViewController.instantiate()
        present(nowPlayingList, animated: true, completion: nil)
    }
    
    override func avplayerDidFinish(_ notification: Notification) {
        super.avplayerDidFinish(notification)
        scrollToActiveTrack()
    }
}

extension PlayerViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return musicPlayer.musicList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as TrackCollectionCell
        cell.updateCell(track: musicPlayer.musicList[indexPath.item])
        return cell
    }
}

extension PlayerViewController: MSPeekImplementationDelegate {
    func peekImplementation(_ peekImplementation: MSPeekCollectionViewDelegateImplementation, didChangeActiveIndexTo activeIndex: Int) {
        guard musicPlayer.index != activeIndex else { return }
        musicPlayer.index = activeIndex
        let url = musicPlayer.prepare(index: activeIndex)
        updateViewWhenChangeTrack(activeIndex)
        musicPlayer.play(url: url)
    }
}

extension PlayerViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
