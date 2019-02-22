//
//  BasicContentView.swift
//  MusicCloud
//
//  Created by thanh on 2/22/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation
import UIKit
import ESTabBarController_swift

class BasicContentView: ESTabBarItemContentView {
    private var duration = 0.3
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configView()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configView() {
        textColor = UIColor.hexStringToUIColor(hex: "afafaf")
        highlightTextColor = UIColor.hexStringToUIColor(hex: "fe492a")
        iconColor = UIColor.hexStringToUIColor(hex: "afafaf")
        highlightIconColor = UIColor.hexStringToUIColor(hex: "fe492a")
    }
}
