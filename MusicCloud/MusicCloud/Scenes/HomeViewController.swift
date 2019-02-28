//
//  HomeViewController.swift
//  MusicCloud
//
//  Created by thanh on 2/22/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit
import Reusable

enum Genre: String, CaseIterable {
    case Disco = "Disco"
    case Rock = "Rock"
    case Pop = "Pop"
    case Dubstep = "Dubstep"
    case Indie = "Indie"
    case Country = "Country"
    case House = "House"
    case Trap = "Trap"
    case Trance = "Trance"
    case Classical = "Classical"
    
    func createGenreParam() -> String {
        switch self {
        case .Disco:
            return APIConstant.DISCO
        case .Country:
            return APIConstant.COUNTRY
        case .Dubstep:
            return APIConstant.DUBSTEP
        case .Indie:
            return APIConstant.INDIE
        case .Rock:
            return APIConstant.ROCK
        case .Pop:
            return APIConstant.POP
        case .House:
            return APIConstant.HOUSE
        case .Trap:
            return APIConstant.TRAP
        case .Trance:
            return APIConstant.TRANCE
        case .Classical:
            return APIConstant.CLASSICAL
        }
    }
}

final class HomeViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var trackRepository = TrackRepository(api: APIService.share)
    private var trackList: [Genre: [Track]] = [Genre.Disco: [Track](),
                                               Genre.Rock: [Track](),
                                               Genre.Pop: [Track](),
                                               Genre.Dubstep: [Track](),
                                               Genre.Indie:[Track](),
                                               Genre.Country: [Track](),
                                               Genre.House: [Track](),
                                               Genre.Trap: [Track](),
                                               Genre.Trance: [Track](),
                                               Genre.Classical: [Track]()]
    private var limit = 20
    private let refreshControl = UIRefreshControl()
    private var storedOffsets = [Int: CGFloat]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        getData()
    }
    
    private func setupViews() {
        navigationItem.title = NavigationConstant.homeNavItemTitle
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(cellType: TableViewCell.self)
        if #available(iOS 10.0, *) {
            tableView.refreshControl = refreshControl
        } else {
            tableView.addSubview(refreshControl)
        }
        refreshControl.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
    }
    
    @objc private func reloadTableView() {
        trackList.keys.forEach {
            trackList[$0] = [Track]()
        }
        getData()
        refreshControl.endRefreshing()
    }
    
    private func getData() {
        getDataByGenre(genre: Genre.Disco)
        getDataByGenre(genre: Genre.Rock)
        getDataByGenre(genre: Genre.Pop)
        getDataByGenre(genre: Genre.Dubstep)
        getDataByGenre(genre: Genre.Indie)
        getDataByGenre(genre: Genre.Country)
        getDataByGenre(genre: Genre.House)
        getDataByGenre(genre: Genre.Trap)
        getDataByGenre(genre: Genre.Trance)
        getDataByGenre(genre: Genre.Classical)
    }
    
    private func getDataByGenre(genre: Genre) {
        trackRepository.getTrackByGenre(genre: genre.createGenreParam(), limit: limit) { (response) in
            switch response {
            case .success(let trackByGenreResponse):
                var list = [Track]()
                for item in (trackByGenreResponse?.tracks)! {
                    let track = item.track
                    list.append(track)
                }
                self.trackList[genre] = list
                self.tableView.reloadData()
            case .failure(let error):
                self.showErrorAlert(message: error?.errorMessage)
            }
        }
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return trackList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(for: indexPath) as TableViewCell
        cell.updateCell(genre: Genre.allCases[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? TableViewCell else { return }
        tableViewCell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let tableViewCell = cell as? TableViewCell else { return }
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 315
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let key = Genre.allCases[collectionView.tag]
        return trackList[key]?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(for: indexPath) as TrackCollectionViewCell
        let key = Genre.allCases[collectionView.tag]
        let list = trackList[key]
        if let track = list?[indexPath.item] {
            cell.updateCell(track: track)
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
