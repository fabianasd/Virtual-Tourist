//
//  EndPoint.swift
//  Virtual-Tourist
//
//  Created by Fabiana Petrovick on 13/07/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import Foundation

enum EndPoint: String {
    case interestingPhotos = "flickr.interestingness.getList"
    case recentPhotos = "flickr.photos.getRecent"
    case locationPhotos = "flickr.photos.search"
    case favoritePhotos = "flickr.favorites.getList"
    case addToFavorites = "flickr.favorites.add"
    case removeFromFavorites = "flickr.favorites.remove"
}
