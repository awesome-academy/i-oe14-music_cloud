//
//  TimeInterval+String.swift
//  MusicCloud
//
//  Created by thanh on 3/2/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation

extension TimeInterval {
    func timeToString() -> String {
        let hours = Int(self / 3600)
        let minutes = Int(self) / 60 % 60
        let seconds = Int(self) % 60
        if hours == 0 {
            return String(format: "%i:%02i", minutes, seconds)
        } else {
            return String(format:"%i:%02i:%02i", hours, minutes, seconds)
        }
    }
}
