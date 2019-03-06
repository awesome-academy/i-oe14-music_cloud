//
//  TrackCountingCell.swift
//  MusicCloud
//
//  Created by thanh on 3/6/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit
import Reusable

protocol ShuffleCellDelegate: class {
    func didTapPlay()
    func didTapShuffle()
}

class TrackCountingCell: UITableViewCell, NibReusable {
    @IBOutlet private weak var trackCountingLabel: UILabel!
    weak var delegate: ShuffleCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCell(count: Int) {
        trackCountingLabel.text = String(count) + " tracks"
    }
    
    @IBAction func playButtonAction(_ sender: Any) {
        delegate?.didTapPlay()
    }
    
    @IBAction func shuffleButtonAction(_ sender: Any) {
        delegate?.didTapShuffle()
    }
}
