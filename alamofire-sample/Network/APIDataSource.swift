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
    
    static func getPopularMovieMappable(type: String, onSuccess: @escaping (_ result: [MovieModel]) -> Void, onFailed: @escaping onFailed) {
        AF.request("\(APIConstant.MOVIE_BASE_URL)\(APIConstant.MOVIE_LIST)\(type)?api_key=\(APIConstant.MOVIE_API_KEY)", method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:]).responseJSON(completionHandler: { response in
            switch response.result {
            case .failure(let error):
                onFailed(error.errorDescription)
            case .success(let data):
                print("Response: \(data)")
                let dao = DAOMoviesMapBaseClass(object: JSON(data))
                var list: [MovieModel] = []
                dao.results?.forEach({ (dt) in
                    list.append(MovieModel(date: dt.releaseDate, title: dt.title, backdrop: "\(APIConstant.MOVIE_IMAGE_URL)\(dt.backdropPath ?? "")", overview: dt.overview))
                })
                onSuccess(list)
            }
        })
    }

    static func getPopularMovieCodable(type: String, onSuccess: @escaping (_ result: [MovieModel]) -> Void, onFailed: @escaping onFailed) {
        AF.request("\(APIConstant.MOVIE_BASE_URL)\(APIConstant.MOVIE_LIST)\(type)?api_key=\(APIConstant.MOVIE_API_KEY)", method: .get, parameters: [:], encoding: URLEncoding.default, headers: [:]).responseDecodable(of: DAOMoviesCodableBaseClass.self) { (response) in
            if let dao = response.value {
                var list: [MovieModel] = []
                dao.results?.forEach({ (dt) in
                    list.append(MovieModel(date: dt.releaseDate, title: dt.title, backdrop: "\(APIConstant.MOVIE_IMAGE_URL)\(dt.backdropPath ?? "")", overview: dt.overview))
                })
                onSuccess(list)
            } else {
                onFailed("Error Not Found")
            }
        }
    }
    
    static func reduceImage(image: UIImage, onSuccess: @escaping (_ img: UIImage?) -> Void) {
        let imageToUpload = image.resizedImage()
        onSuccess(imageToUpload)
    }
    
    public static func doUploadImage(image: UIImage, onSuccess: @escaping (_ id: String, _ message: String) -> Void, onFailed: @escaping onFailed) {
        
        guard let url = URL(string: APIConstant.UPLOAD_IMAGE) else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.method = .post
        
        AF.upload(multipartFormData: { (multipart) in
            self.reduceImage(image: image) { (image) in
                let imageToUpload = image
                multipart.append(imageToUpload?.pngData() ?? Data(), withName: "image", fileName: "image.png", mimeType: "image/png")
            }
        }, with: urlRequest).responseJSON(completionHandler: { response in
            switch response.result {
            case .failure(let error):
                onFailed(error.errorDescription)
            case .success(let data):
                print("Response: \(data)")
                let response = JSON(data)
                let success = response["code"].intValue
                let id = response["data"]["uniqueId"].stringValue
                let error = response["status_message"].stringValue
                if success == 200 {
                    onSuccess(id, "You have successfully edit Your Profile Photo.")
                } else {
                    onFailed(error)
                }
            }
        })
        
    }
}
