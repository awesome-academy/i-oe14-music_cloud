//
//  AppDelegate.swift
//  MusicCloud
//
//  Created by thanh on 2/19/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import UIKit
import IQKeyboardManager
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        configKeyboard()
        allowPlayBackground()
        return true
    }
    
    private func configKeyboard() {
        IQKeyboardManager.shared().isEnabled = true
        IQKeyboardManager.shared().isEnableAutoToolbar = false
    }
    
    private func allowPlayBackground() {
        let session = AVAudioSession.sharedInstance()
        do {
            try session.setCategory(.playback, mode: .default, options: .mixWithOthers)
            try session.setActive(true)
        } catch {
            print(error.localizedDescription)
        }
    }
}

