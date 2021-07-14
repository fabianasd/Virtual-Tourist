//
//  RequestAcessToken.swift
//  Virtual-Tourist
//
//  Created by Fabiana Petrovick on 13/07/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import Foundation

struct RequestAccessTokenInput {
    let consumerKey: String
    let consumerSecret: String
    let requestToken: String // = RequestOAuthTokenResponse.oauthToken
    let requestTokenSecret: String // = RequestOAuthTokenResponse.oauthTokenSecret
    let oauthVerifier: String
}

struct RequestAccessTokenResponse {
    let accessToken: String
    let accessTokenSecret: String
    let userId: String
    let screenName: String
}
