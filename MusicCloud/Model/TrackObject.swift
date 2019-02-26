//
//  ErrorResponse.swift
//  MusicCloud
//
//  Created by thanh on 2/26/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation
import ObjectMapper

final class TrackObject: BaseModel {
    var track = Track()
    var score = 0
    
    init() {
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        track <- map["track"]
        score <- map["score"]
    }
}
