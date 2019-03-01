//
//  TrackCollectionViewCell.swift
//  MusicCloud
//
//  Created by thanh on 2/28/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit
import Reusable
import Kingfisher

final class TrackCollectionViewCell: UICollectionViewCell, NibReusable {

    @IBOutlet private weak var artworkImg: UIImageView!
    @IBOutlet private weak var titleLb: UILabel!
    @IBOutlet private weak var artistLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(track: Track) {
        artworkImg.kf.setImage(with: URL(string: track.artworkURL))
        titleLb.text = track.title
        artistLb.text = track.user.username
    }
}
