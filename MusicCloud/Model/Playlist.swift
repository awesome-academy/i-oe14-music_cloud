//
//  ErrorResponse.swift
//  MusicCloud
//
//  Created by thanh on 2/26/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation
import ObjectMapper

final class Playlist: BaseModel {
    var id = 0
    var kind = ""
    var title = ""
    var artworkUrl = ""
    var description = ""
    var genre = ""
    var likesCount = 0
    var permalink = ""
    var uri = ""
    var userId = 0
    var tracksList = [Track]()
    var trackCount = 0
    var user = User()
    
    init() {
    }
    
    required init?(map: Map) {
        mapping(map: map)
    }
    
    func mapping(map: Map) {
        id <- map["id"]
        kind <- map["kind"]
        title <- map["title"]
        description <- map["description"]
        genre <- map["genre"]
        likesCount <- map["likes_count"]
        permalink <- map["permalink"]
        uri <- map["uri"]
        userId <- map["user_id"]
        tracksList <- map["tracks"]
        trackCount <- map["track_count"]
        user <- map["user"]
    }
}
