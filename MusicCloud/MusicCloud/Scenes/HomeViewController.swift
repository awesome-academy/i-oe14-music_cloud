//
//  HomeViewController.swift
//  MusicCloud
//
//  Created by thanh on 2/22/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit
import Reusable

struct TableViewConstant {
    static let limit = 20
    static let heightForTableViewCell = 315
    static let sizeForCollectionViewCell = CGSize(width: 150, height: 180)
    static let refreshing = "Refreshing data"
}

final class HomeViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    private var trackRepository = TrackRepository(api: APIService.share)
    private var trackList: [Genre: [Track]] = [:]
    private let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createDictionary()
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
        refreshControl.tintColor = UIColor.lightGray
        refreshControl.attributedTitle = NSAttributedString(string: TableViewConstant.refreshing,
                                                            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray])
        refreshControl.addTarget(self, action: #selector(reloadTableView), for: .valueChanged)
    }
    
    private func createDictionary() {
        Genre.allCases.forEach { (genre) in
            trackList[genre] = [Track]()
        }
    }
    
    @objc private func reloadTableView() {
        trackList.keys.forEach {
            trackList[$0] = [Track]()
        }
        getData()
        refreshControl.endRefreshing()
    }
    
    private func getData() {
        trackList.keys.forEach { (genre) in
            getDataByGenre(genre: genre)
        }
    }
    
    private func getDataByGenre(genre: Genre) {
        trackRepository.getTrackByGenre(genre: genre.createGenreParam(), limit: TableViewConstant.limit) { [weak self] response in
            switch response {
            case .success(let trackByGenreResponse):
                var list = [Track]()
                guard let tracks = trackByGenreResponse?.tracks else { return }
                for item in tracks {
                    let track = item.track
                    list.append(track)
                }
                guard let self = self else { return }
                self.trackList[genre] = list
                self.tableView.reloadData()
            case .failure(let error):
                guard let self = self else { return }
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
        cell.updateCell(genre: Genre.allCases[indexPath.row], list: trackList[Genre.allCases[indexPath.row]] ?? [])
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(TableViewConstant.heightForTableViewCell)
    }
}

extension HomeViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
