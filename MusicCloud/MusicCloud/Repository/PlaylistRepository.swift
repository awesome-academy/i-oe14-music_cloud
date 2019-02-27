//
//  ErrorResponse.swift
//  MusicCloud
//
//  Created by thanh on 2/26/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation
import ObjectMapper

protocol PlaylistRepositoryType {
    func searchPlaylists(keyword: String, limit: Int, offset: Int, completion: @escaping (BaseResult<SearchPlaylistResponse>) -> Void)
}

final class PlaylistRepository: PlaylistRepositoryType {
    private var api: APIService!
    
    required init(api: APIService) {
        self.api = api
    }
    
    func searchPlaylists(keyword: String, limit: Int, offset: Int, completion: @escaping (BaseResult<SearchPlaylistResponse>) -> Void) {
        let input = SearchRequest(keyword: keyword, limit: limit, offset: offset, url: APIConstant.APISearchPlaylistUrl)
        api?.request(input: input) { (object: SearchPlaylistResponse?, error) in
            guard let object = object else {
                guard let error = error else {
                    completion(.failure(error: nil))
                    return
                }
                completion(.failure(error: error as? BaseError))
                return
            }
            completion(.success(object))
        }
    }
}
