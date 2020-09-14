//
//  APIConstant.swift
//  alamofire-sample
//
//  Created by IRFAN TRIHANDOKO on 08/09/20.
//  Copyright © 2020 IRFAN TRIHANDOKO. All rights reserved.
//

import Foundation

struct APIConstant {
    
    static let MOVIE_BASE_URL = "https://api.themoviedb.org/3"
    static let MOVIE_API_KEY = "1deaa9125142c48f15f2ddd535939ba3"
    static let MOVIE_IMAGE_URL = "https://image.tmdb.org/t/p/w300"
    
    static let MOVIE_LIST = "/movie/"
    
    static let MOVIE_TOKEN = "/authentication/token/new"
    static let MOVIE_LOGIN = "/authentication/token/validate_with_login"
    
    static let UPLOAD_IMAGE = GITSApps.uploadImage()
    static let GET_IMAGE = GITSApps.getImage()
    
}
