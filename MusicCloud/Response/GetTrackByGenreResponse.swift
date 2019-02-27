//
//  ErrorResponse.swift
//  MusicCloud
//
//  Created by thanh on 2/26/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation
import ObjectMapper

final class GetTrackByGenreResponse: Mappable {
    var tracks: [TrackObject]?
    var kind: String?
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        tracks <- map["collection"]
        kind <- map["kind"]
    }
}
