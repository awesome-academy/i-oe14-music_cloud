//
//  ErrorResponse.swift
//  MusicCloud
//
//  Created by thanh on 2/26/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation
import ObjectMapper
import MediaPlayer

enum TrackType {
    case offlineTrack
    case onlineTrack
}

final class Track: BaseModel {
    var artworkURL = ""
    var createAt = ""
    var duration = 0
    var description = ""
    var genre = ""
    var id = 0
    var kind = ""
    var permalink = ""
    var userId = 0
    var playbackCount = 0
    var likeCount = 0
    var title = ""
    var uri = ""
    var urn = ""
    var user = User()
    var artistName = ""
    var type = TrackType.onlineTrack
    var offlineAvatar: UIImage?
    var offlineURL: URL?
    
    init() {
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        artworkURL <- map["artwork_url"]
        createAt <- map["create_at"]
        description <- map["duration"]
        genre <- map["genre"]
        id <- map["id"]
        kind <- map["kind"]
        likeCount <- map["likes_count"]
        permalink <- map["permalink"]
        playbackCount <- map["playback_count"]
        userId <- map["user_id"]
        title <- map["title"]
        uri <- map["uri"]
        urn <- map["urn"]
        user <- map["user"]
    }
}
