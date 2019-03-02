//
//  TableViewCell.swift
//  MusicCloud
//
//  Created by thanh on 2/28/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit
import Reusable

final class TableViewCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    let musicPlayer = MediaManager.getInstance()
    var trackList = [Track]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configCollectionView()
    }
    
    private func configCollectionView() {
        collectionView.register(cellType: TrackCollectionViewCell.self)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    func updateCell(genre: Genre, list: [Track]) {
        genreLabel.text = genre.rawValue
        trackList = list
        collectionView.reloadData()
    }
}

extension TableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return trackList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as TrackCollectionViewCell
        let track = trackList[indexPath.item]
        cell.updateCell(track: track)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        musicPlayer.musicList = trackList
        musicPlayer.index = indexPath.row
        musicPlayer.stop()
        let streamUrl = musicPlayer.prepare(index: musicPlayer.index)
        musicPlayer.play(url: streamUrl)
    }
}

extension TableViewCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return TableViewConstant.sizeForCollectionViewCell
    }
}
