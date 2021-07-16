//
//  FlickrPhotosResponse.swift
//  Virtual-Tourist
//
//  Created by Fabiana Petrovick on 13/07/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import Foundation

struct FlickrPhotosResponse: Codable {
    let photos: [Photo]
     let results: [Map]
    
    enum CodingKeys: String, CodingKey {
        case photos = "photo"
        case results = "results"
    }
}
