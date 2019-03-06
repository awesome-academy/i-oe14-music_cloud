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
    
    public static let DISCO = "soundcloud:genres:disco"
    public static let INDIE = "soundcloud:genres:indie"
    public static let TRAP = "soundcloud:genres:trap"
    public static let TRANCE = "soundcloud:genres:trance"
    public static let DUBSTEP = "soundcloud:genres:dubstep"
    public static let POP = "soundcloud:genres:pop"
    public static let HOUSE = "soundcloud:genres:house"
    public static let CLASSICAL = "soundcloud:genres:classical"
    public static let COUNTRY = "soundcloud:genres:country"
    public static let ROCK = "soundcloud:genres:rock"
}
