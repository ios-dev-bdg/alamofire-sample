//
//  APIDataSource.swift
//  alamofire-sample
//
//  Created by IRFAN TRIHANDOKO on 17/03/20.
//  Copyright © 2020 IRFAN TRIHANDOKO. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

public typealias onSuccess = (_ result: Any)->()
public typealias onFailed = (_ message: String?)->()

public struct APIDataSource {
    
    public static func getPopularMovie(type: String, onSuccess: @escaping onSuccess, onFailed: @escaping onFailed) {
        AF.request("\(APIConstant.moviesURL)\(APIConstant.movieList)\(type)?api_key=\(APIConstant.moviesAPIKey)", method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:]).responseJSON(completionHandler: { response in
            switch response.result {
                case .failure(let error):
                    onFailed(error.errorDescription)
                case .success(let data):
                    print("Response: \(data)")
                    onSuccess(data)
            }
        })
    }
    
    public static func doGetToken(onSuccess: @escaping onSuccess, onFailed: @escaping onFailed) {
        AF.request("\(APIConstant.moviesURL)\(APIConstant.movieToken)?api_key=\(APIConstant.moviesAPIKey)", method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:]).responseJSON(completionHandler: { response in
            switch response.result {
                case .failure(let error):
                    onFailed(error.errorDescription)
                case .success(let data):
                    print("Response: \(data)")
                    let isSuccess = JSON(data)["success"].boolValue
                    let message = JSON(data)["status_message"].stringValue
                    if isSuccess == true {
                        onSuccess(data)
                    } else {
                        onFailed(message)
                    }
            }
        })
    }
    
    public static func doLogin(username: String, password: String, requestToken: String, onSuccess: @escaping onSuccess, onFailed: @escaping onFailed) {
        let bodyParam = ["username": username,
                         "password": password,
                         "request_token": requestToken]
        AF.request("\(APIConstant.moviesURL)\(APIConstant.movieLogin)?api_key=\(APIConstant.moviesAPIKey)", method: .post, parameters: bodyParam, encoding: JSONEncoding.default, headers: [:]).responseJSON(completionHandler: { response in
            switch response.result {
                case .failure(let error):
                    onFailed(error.errorDescription)
                case .success(let data):
                    print("Response: \(data)")
                    let isSuccess = JSON(data)["success"].boolValue
                    let message = JSON(data)["status_message"].stringValue
                    if isSuccess == true {
                        onSuccess(data)
                    } else {
                        onFailed(message)
                    }
            }
        })
    }
}
