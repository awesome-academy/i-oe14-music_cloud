//
//  OfflineMusicViewController.swift
//  MusicCloud
//
//  Created by thanh on 2/22/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit
import Reusable

final class OfflineMusicViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews() {
        navigationItem.title = NavigationConstant.offlineMusicNavItemTitle
    }
}

extension OfflineMusicViewController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
