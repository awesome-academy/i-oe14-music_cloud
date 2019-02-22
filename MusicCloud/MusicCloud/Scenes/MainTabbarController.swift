//
//  MainTabbarController.swift
//  MusicCloud
//
//  Created by thanh on 2/22/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit
import Reusable
import ESTabBarController_swift

struct NavigationConstant {
    static let homeNavItemTitle = "Home"
    static let offlineMusicNavItemTitle = "OfflineMusic"
    static let searchNavItemTitle = "Search"
    static let libraryNavItemTitle = "Library"
    static let titleFontName = "SFProText-Semibold"
    static let navBarTintColor = 0xC0C0C0
}

class MainTabbarController: ESTabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configTabbar()
    }
    
    private func configTabbar() {
        let homeNavController = configNavController(viewController: HomeViewController.instantiate(),
                                                    title: NavigationConstant.homeNavItemTitle,
                                                    image: "Home",
                                                    selectedImage: "HomeHighlighted")
        let offlineMusicNavController = configNavController(viewController: OfflineMusicViewController.instantiate(),
                                                            title: NavigationConstant.offlineMusicNavItemTitle,
                                                            image: "OfflineMusic",
                                                            selectedImage: "OfflineMusicHighlighted")
        let searchNavController = configNavController(viewController: SearchViewController.instantiate(),
                                                      title: NavigationConstant.searchNavItemTitle,
                                                      image: "Search",
                                                      selectedImage: "SearchHighlighted")
        let libraryNavController = configNavController(viewController: LibraryViewController.instantiate(),
                                                       title: NavigationConstant.libraryNavItemTitle,
                                                       image: "Profile",
                                                       selectedImage: "ProfileHighlighted")
        viewControllers = [homeNavController, offlineMusicNavController, searchNavController, libraryNavController]
    }
    
    private func configNavController(viewController: UIViewController, title: String, image: String,
                                     selectedImage: String) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        navController.navigationBar.titleTextAttributes = [
            kCTForegroundColorAttributeName: UIColor.gray,
            kCTFontAttributeName: UIFont(name: NavigationConstant.titleFontName, size: 14) ?? UIFont.systemFont(ofSize: 14)
        ] as [NSAttributedString.Key: Any]
        navController.navigationBar.tintColor = UIColor.color(NavigationConstant.navBarTintColor)
        navController.tabBarItem = ESTabBarItem.init(BouncesContentView(),
                                                     title: title,
                                                     image: UIImage(named: image),
                                                     selectedImage: UIImage(named: selectedImage))
        return navController
    }
}

extension MainTabbarController: StoryboardSceneBased {
    static var sceneStoryboard = Storyboards.main
}
