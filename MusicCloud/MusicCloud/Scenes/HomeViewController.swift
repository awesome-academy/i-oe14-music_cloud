//
//  HomeViewController.swift
//  MusicCloud
//
//  Created by thanh on 2/22/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit
import Reusable

struct Genres {
    static let POP = "Pop"
    static let DISCO = "Disco"
    static let ROCK = "Rock"
    static let INDIE = "Indie"
    static let DUBSTEP = "Dubstep"
    static let COUNTRY = "Country"
}

final class HomeViewController: UIViewController {
    @IBOutlet weak var discoCollectionView: UICollectionView!
    @IBOutlet weak var discoGenre: UILabel!
    @IBOutlet weak var rockGenre: UILabel!
    @IBOutlet weak var rockCollectionView: UICollectionView!
    @IBOutlet weak var indieGenre: UILabel!
    @IBOutlet weak var indieCollectionView: UICollectionView!
    @IBOutlet weak var dubstepGenre: UILabel!
    @IBOutlet weak var dubstepCollectionView: UICollectionView!
    @IBOutlet weak var popGenre: UILabel!
    @IBOutlet weak var popCollectionView: UICollectionView!
    @IBOutlet weak var countryGenre: UILabel!
    @IBOutlet weak var countryCollectionView: UICollectionView!
    
    var discoList = [Track]()
    var rockList = [Track]()
    var indieList = [Track]()
    var dubstepList = [Track]()
    var popList = [Track]()
    var countryList = [Track]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupCollectionView()
    }
    
    private func setupViews() {
        navigationItem.title = NavigationConstant.homeNavItemTitle
        discoGenre.text = Genres.DISCO
        rockGenre.text = Genres.ROCK
        popGenre.text = Genres.POP
        dubstepGenre.text = Genres.DUBSTEP
        indieGenre.text = Genres.INDIE
        countryGenre.text = Genres.COUNTRY
    }
    
    private func setupCollectionView() {
        discoCollectionView.delegate = self
        discoCollectionView.dataSource = self
        discoCollectionView.register(cellType: HomeTrackCell.self)
        rockCollectionView.delegate = self
        rockCollectionView.dataSource = self
        rockCollectionView.register(cellType: HomeTrackCell.self)
        indieCollectionView.delegate = self
        indieCollectionView.dataSource = self
        indieCollectionView.register(cellType: HomeTrackCell.self)
        dubstepCollectionView.delegate = self
        dubstepCollectionView.dataSource = self
        dubstepCollectionView.register(cellType: HomeTrackCell.self)
        popCollectionView.delegate = self
        popCollectionView.dataSource = self
        popCollectionView.register(cellType: HomeTrackCell.self)
        countryCollectionView.delegate = self
        countryCollectionView.dataSource = self
        countryCollectionView.register(cellType: HomeTrackCell.self)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView {
        case discoCollectionView:
            return discoList.count
        case rockCollectionView:
            return rockList.count
        case indieCollectionView:
            return indieList.count
        case dubstepCollectionView:
            return dubstepList.count
        case popCollectionView:
            return popList.count
        case countryCollectionView:
            return countryList.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath, cellType: HomeTrackCell.self)
        switch collectionView {
        case discoCollectionView:
            cell.updateCell(track: discoList[indexPath.item])
        case rockCollectionView:
            cell.updateCell(track: rockList[indexPath.item])
        case indieCollectionView:
            cell.updateCell(track: indieList[indexPath.item])
        case dubstepCollectionView:
            cell.updateCell(track: dubstepList[indexPath.item])
        case popCollectionView:
            cell.updateCell(track: popList[indexPath.row])
        case countryCollectionView:
            cell.updateCell(track: countryList[indexPath.row])
        default:
            break
        }
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 180)
    }
}

extension HomeViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
