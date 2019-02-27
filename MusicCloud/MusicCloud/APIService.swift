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

struct APIService {
    static let share = APIService()
    private var alamofireManager = Alamofire.Session.default
    
    init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30
        configuration.timeoutIntervalForResource = 30
        alamofireManager = Alamofire.Session(configuration: configuration)
    }
    
    func request<T: Mappable>(input: BaseRequest, completion: @escaping (_ value: T?,_ error: Error?) -> Void) {
        alamofireManager.request(input.url, method: input.requestType, parameters: input.body, encoding: input.encoding)
            .validate(statusCode: 200..<500)
            .responseJSON { response in
                switch response.result {
                case .failure(let error):
                    completion(nil, error)
                case .success(let value):
                    guard let statusCode = response.response?.statusCode else {
                        completion(nil, BaseError.unexpectedError)
                        return
                    }
                    if statusCode == 200 {
                        let object = Mapper<T>().map(JSONObject: value)
                        completion(object, nil)
                    } else {
                        guard let error = Mapper<ErrorResponse>().map(JSONObject: value) else {
                            completion(nil, BaseError.httpError(httpCode: statusCode))
                            return
                        }
                        completion(nil, BaseError.apiFailure(error: error))
                    }
                }
        }
    }
}

