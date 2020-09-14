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

typealias onFailed = (_ message: String?) -> ()

struct APIDataSource {
    
    static func doGetToken(onSuccess: @escaping () -> Void, onFailed: @escaping onFailed) {
        AF.request("\(APIConstant.MOVIE_BASE_URL)\(APIConstant.MOVIE_TOKEN)?api_key=\(APIConstant.MOVIE_API_KEY)", method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:]).responseJSON(completionHandler: { response in
            switch response.result {
                case .failure(let error):
                    onFailed(error.errorDescription)
                case .success(let data):
                    print("Response: \(data)")
                    let response = JSON(data)
                    let isSuccess = response["success"].boolValue
                    let error = response["status_message"].stringValue
                    if isSuccess == true {
                        let token = response["request_token"].stringValue
                        UserDefaults.standard.set(token, forKey: "REQ_TOKEN")
                        onSuccess()
                    } else {
                        onFailed(error)
                    }
            }
        })
    }
    
    static func doLogin(username: String, password: String, onSuccess: @escaping (_ result: String) -> Void, onFailed: @escaping onFailed) {
        let token = UserDefaults.standard.string(forKey: "REQ_TOKEN")
        let bodyParam = ["username": username,
                         "password": password,
                         "request_token": token ?? ""]
        
        AF.request("\(APIConstant.MOVIE_BASE_URL)\(APIConstant.MOVIE_LOGIN)?api_key=\(APIConstant.MOVIE_API_KEY)", method: .post, parameters: bodyParam, encoding: JSONEncoding.default, headers: [:]).responseJSON(completionHandler: { response in
            switch response.result {
                case .failure(let error):
                    onFailed(error.errorDescription)
                case .success(let data):
                    print("Response: \(data)")
                    let response = JSON(data)
                    let isSuccess = response["success"].boolValue
                    let error = response["status_message"].stringValue
                    if isSuccess == true {
                        onSuccess("You have successfully signed into Your account.")
                    } else {
                        onFailed(error)
                    }
            }
        })
    }
    
    static func getPopularMovie(type: String, onSuccess: @escaping (_ result: [MovieModel]) -> Void, onFailed: @escaping onFailed) {
        AF.request("\(APIConstant.MOVIE_BASE_URL)\(APIConstant.MOVIE_LIST)\(type)?api_key=\(APIConstant.MOVIE_API_KEY)", method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:]).responseJSON(completionHandler: { response in
            switch response.result {
                case .failure(let error):
                    onFailed(error.errorDescription)
                case .success(let data):
                    print("Response: \(data)")
                    let dao = DAOPopularMovieBaseClass(object: JSON(data))
                    var list: [MovieModel] = []
                    for dt in dao.results ?? [] {
                        list.append(MovieModel(date: dt.releaseDate, title: dt.title, backdrop: "\(APIConstant.MOVIE_IMAGE_URL)\(dt.backdropPath ?? "")", overview: dt.overview))
                    }
                    onSuccess(list)
            }
        })
    }
}
