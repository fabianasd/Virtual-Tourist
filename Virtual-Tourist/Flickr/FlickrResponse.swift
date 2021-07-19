//
//  FlickrResponse.swift
//  Virtual-Tourist
//
//  Created by Fabiana Petrovick on 17/07/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import Foundation

struct FlickrResponse: Codable {
    var photos: Photos
    let stat: String
    
    enum CodingKeys: String, CodingKey {
        case photos
        case stat
    }
}

struct Photos: Codable {
    let page: Int
    let pages: Int
    let perpage: Int
    let total: Int
    let photo: [Photo]
    
    enum CodingKeys: String, CodingKey {
        case page
        case pages
        case perpage
        case total
        case photo
    }
}
