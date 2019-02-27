//
//  ErrorResponse.swift
//  MusicCloud
//
//  Created by thanh on 2/26/19.
//  Copyright © 2019 thanh. All rights reserved.
//

import Foundation
import ObjectMapper

protocol UserRepositoryType {
    func searchUsers(keyword: String, limit: Int, offset: Int, completion: @escaping (BaseResult<SearchUserResponse>) -> Void)
}

final class UserRepository: UserRepositoryType {
    private var api: APIService!
    
    required init(api: APIService) {
        self.api = api
    }
    
    func searchUsers(keyword: String, limit: Int, offset: Int, completion: @escaping (BaseResult<SearchUserResponse>) -> Void) {
        let input = SearchRequest(keyword: keyword, limit: limit, offset: offset, url: APIConstant.APISearchUserUrl)
        api?.request(input: input) { (object: SearchUserResponse?, error) in
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
