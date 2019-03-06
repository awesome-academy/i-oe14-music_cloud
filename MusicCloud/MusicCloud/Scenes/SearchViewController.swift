//
//  SearchViewController.swift
//  MusicCloud
//
//  Created by thanh on 2/22/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit
import Reusable

final class SearchViewController: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        navigationItem.title = NavigationConstant.searchNavItemTitle
    }
}

extension SearchViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
