//
//  ErrorResponse.swift
//  MusicCloud
//
//  Created by thanh on 2/26/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation
import ObjectMapper

final class User: BaseModel {
    var avatarUrl = ""
    var city = ""
    var commentCount = 0
    var createAt = ""
    var description = ""
    var followerCount = 0
    var followingCount = 0
    var firstname = ""
    var fullname = ""
    var id = 0
    var kind = ""
    var lastname = ""
    var permalink = ""
    var trackCount = 0
    var playlistCount = 0
    var uri = ""
    var urn = ""
    var username = ""
    
    init() {
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        avatarUrl <- map["avatar_url"]
        id <- map["id"]
        city <- map["city"]
        commentCount <- map["comments_count"]
        createAt <- map["create_at"]
        description <- map["description"]
        followerCount <- map["followers_count"]
        followingCount <- map["followings_count"]
        firstname <- map["first_name"]
        fullname <- map["full_name"]
        id <- map["id"]
        kind <- map["kind"]
        lastname <- map["last_name"]
        permalink <- map["permalink"]
        trackCount <- map["track_count"]
        playlistCount <- map["playlist_count"]
        uri <- map["uri"]
        urn <- map["urn"]
        username <- map["username"]
    }
}
