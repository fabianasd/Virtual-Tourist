//
//  RequestOAuthToken.swift
//  Virtual-Tourist
//
//  Created by Fabiana Petrovick on 13/07/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import Foundation

struct RequestOAuthTokenInput {
    let consumerKey: String
    let consumerSecret: String
    let callbackScheme: String
}

struct RequestOAuthTokenResponse {
    let oauthToken: String
    let oauthTokenSecret: String
    let oauthCallbackConfirmed: String
}
