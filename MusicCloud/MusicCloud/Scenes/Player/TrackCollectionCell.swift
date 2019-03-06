//
//  TrackCollectionCell.swift
//  MusicCloud
//
//  Created by thanh on 3/3/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit
import Reusable

class TrackCollectionCell: UICollectionViewCell, NibReusable {
    @IBOutlet weak var artworkImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(track: Track) {
        switch track.type {
        case .offlineTrack:
            artworkImg.image = track.offlineAvatar
        case .onlineTrack:
            artworkImg.kf.setImage(with: URL(string: track.artworkURL))
        }
    }
}
