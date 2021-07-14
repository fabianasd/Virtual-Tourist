//
//  FlickrFavoritesResponse.swift
//  Virtual-Tourist
//
//  Created by Fabiana Petrovick on 13/07/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import Foundation

struct FlickrFavoritesResponse: Codable {
    let stat: String
    let code: String?
    let message: String?
}
