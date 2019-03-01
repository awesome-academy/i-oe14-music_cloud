//
//  ErrorResponse.swift
//  MusicCloud
//
//  Created by thanh on 2/26/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

final class TracksByGenreRequest: BaseRequest {
    required init(genre: String, limit: Int, url: String) {
        let body: [String: Any] = ["kind": "top",
                                   "genre": genre,
                                   "limit": limit,
                                   "offset": 0]
        super.init(url: APIConstant.APIGetTrackByGenreUrl, requestType: .get, body: body)
    }
}
