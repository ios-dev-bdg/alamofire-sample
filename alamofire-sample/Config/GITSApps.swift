//
//  GITSApp.swift
//  alamofire-sample
//
//  Created by IRFAN TRIHANDOKO on 14/09/20.
//  Copyright © 2020 IRFAN TRIHANDOKO. All rights reserved.
//

import Foundation

public struct GITSApps{
    
    static let GITSConfigBundle = [
       "base_url" :""
    ]
    
    public static func config() -> Dictionary<String, Any>? {
        var myDict: Dictionary<String, Any>?
        if let path = Bundle.main.path(forResource: "KMConfig", ofType: "plist"), let dict = NSDictionary(contentsOfFile: path) as? [String: Any] {
            myDict = dict
        }
        
        if let url = Bundle.main.url(forResource: "KMConfig", withExtension: "plist") {
            debugPrint(url)
        } else {
            debugPrint("No url")
        }
        
        return myDict
    }
    
    public static func uploadImage() -> String{
        if let config = config() {
            return config["upload_image"] as! String
        } else {
            return ""
        }
    }
    
    public static func getImage() -> String{
        if let config = config() {
            return config["get_image"] as! String
        } else {
            return ""
        }
    }
    
}
