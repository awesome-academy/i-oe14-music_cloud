//
//  SplashViewController.swift
//  MusicCloud
//
//  Created by thanh on 2/21/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit

final class SplashViewController: UIViewController {
    @IBOutlet private weak var progressView: UIView!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showIndicator()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        prepareViewController()
    }
    
    private func showIndicator() {
        let activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.startAnimating()
        activityIndicator.center = CGPoint(x: progressView.bounds.size.width/2, y: progressView.bounds.size.height/2)
        progressView.addSubview(activityIndicator)
    }
    
    private func prepareViewController() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            let tabbarController = MainTabbarController.instantiate()
            if let app = UIApplication.shared.delegate as? AppDelegate {
                app.window?.rootViewController = tabbarController
            }
        }
    }
}
