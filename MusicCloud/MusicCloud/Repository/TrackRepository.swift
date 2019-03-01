//
//  ErrorResponse.swift
//  MusicCloud
//
//  Created by thanh on 2/26/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation
import ObjectMapper

protocol TrackRepositoryType {
    func searchTracks(keyword: String, limit: Int, offset: Int, completion: @escaping (BaseResult<SearchTrackResponse>) -> Void)
}

final class TrackRepository: TrackRepositoryType {
    private var api: APIService!
    
    required init(api: APIService) {
        self.api = api
    }
    
    func searchTracks(keyword: String, limit: Int, offset: Int, completion: @escaping (BaseResult<SearchTrackResponse>) -> Void) {
        let input = SearchRequest(keyword: keyword, limit: limit, offset: offset, url: APIConstant.APISearchTrackUrl)
        api?.request(input: input) { (object: SearchTrackResponse?, error) in
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
    
    func getTrackByGenre(genre: String, limit: Int, completion: @escaping (BaseResult<GetTrackByGenreResponse>) -> Void) {
        let input = TracksByGenreRequest(genre: genre, limit: limit, url: APIConstant.APIGetTrackByGenreUrl)
        api?.request(input: input, completion: { (object: GetTrackByGenreResponse?, error) in
            guard let object = object else {
                guard let error = error else {
                    completion(.failure(error: nil))
                    return
                }
                completion(.failure(error: error as? BaseError))
                return
            }
            completion(.success(object))
        })
    }
}
