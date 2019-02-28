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
    @IBOutlet private weak var genreLb: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func updateCell(genre: Genre) {
        genreLb.text = genre.rawValue
    }
}

extension TableViewCell {
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSourceDelegate: D, forRow row: Int) {
        collectionView.register(cellType: TrackCollectionViewCell.self)
        collectionView.delegate = dataSourceDelegate
        collectionView.dataSource = dataSourceDelegate
        collectionView.tag = row
        collectionView.setContentOffset(collectionView.contentOffset, animated:false) // Stops collection view if it was scrolling.
        collectionView.reloadData()
    }
    
    var collectionViewOffset: CGFloat {
        set { collectionView.contentOffset.x = newValue }
        get { return collectionView.contentOffset.x }
    }
}
