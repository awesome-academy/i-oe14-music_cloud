//
//  HomeTrackCell.swift
//  MusicCloud
//
//  Created by thanh on 2/27/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit
import Kingfisher
import Reusable

class HomeTrackCell: UICollectionViewCell, NibReusable {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var artistLb: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        img.image = UIImage(color: .lightGray)
    }
    
    func updateCell(track: Track) {
        titleLb.text = track.title
        img.kf.setImage(with: URL(string: track.artworkURL))
        artistLb.text = track.user.username
    }
}
