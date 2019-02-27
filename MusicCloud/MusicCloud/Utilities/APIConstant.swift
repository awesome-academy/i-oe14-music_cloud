//
//  ErrorResponse.swift
//  MusicCloud
//
//  Created by thanh on 2/26/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation

struct APIConstant {
    private static var APIBaseURL = "https://api-v2.soundcloud.com"
    public static let APISearchUserUrl = APIBaseURL + "/search/users?"
    public static let APISearchPlaylistUrl = APIBaseURL + "/search/playlists"
    public static let APISearchTrackUrl = APIBaseURL + "/search/tracks"
    public static let APIGetTrackByGenreUrl = APIBaseURL + "/charts"
    
    public static let DISCO = "soundcloud%3Agenres%3Adisco"
    public static let INDIE = "soundcloud%3Agenres%3Aindie"
    public static let TRAP = "soundcloud%3Agenres%3Atrap"
    public static let TRANCE = "soundcloud%3Agenres%3Atrance"
    public static let DUBSTEP = "soundcloud%3Agenres%3Adubstep"
    public static let POP = "soundcloud%3Agenres%3Apop"
    public static let HOUSE = "soundcloud%3Agenres%3Ahouse"
    public static let CLASSICAL = "soundcloud%3Agenres%3Aclassical"
    public static let COUNTRY = "soundcloud%3Agenres%3Acountry"
    public static let ROCK = "soundcloud%3Agenres%3Arock"
}
