//
//  FlickrAPI.swift
//  Virtual-Tourist
//
//  Created by Fabiana Petrovick on 13/07/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import Foundation

struct FlickrAPI {
    // urls
    static let baseURLString = "https://api.flickr.com/services/rest"
    static let requestTokenURL = "https://www.flickr.com/services/oauth/request_token"
    static let authorizeURL = "https://www.flickr.com/services/oauth/authorize"
    static let accessTokenURL = "https://www.flickr.com/services/oauth/access_token"
    
    // keys and tokens
    static let apiKey = "7b12c78e0a4692fc63e5896846edb1af"
    static let secretKey = "41f573255ffa3449"
}
