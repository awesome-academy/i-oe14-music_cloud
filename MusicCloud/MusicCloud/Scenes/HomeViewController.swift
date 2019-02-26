//
//  HomeViewController.swift
//  MusicCloud
//
//  Created by thanh on 2/22/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit
import Reusable

final class HomeViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        navigationItem.title = NavigationConstant.homeNavItemTitle
    }
}

extension HomeViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
