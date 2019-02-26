//
//  ErrorResponse.swift
//  MusicCloud
//
//  Created by thanh on 2/26/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation
import ObjectMapper

final class SearchRequest: BaseRequest {
    required init(keyword: String, limit: Int, offset: Int, url: String) {
        let body: [String: Any] = ["q": keyword,
                                   "limit": limit,
                                   "offset": offset]
        super.init(url: url, requestType: .get, body: body)
    }
}
