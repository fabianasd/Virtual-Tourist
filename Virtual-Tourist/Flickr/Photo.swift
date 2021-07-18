//
//  Photo.swift
//  Virtual-Tourist
//
//  Created by Fabiana Petrovick on 13/07/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import Foundation

struct Photo: Codable, Equatable {
    let title: String
    let remoteURL: URL?
    let id: String
    let dateTaken: String
    let height: Int?
    let width: Int?
    let owner: String
    let views: String
    let license: String
    var latitude: String
    var longitude: String
    var accuracy: String 
    
    enum CodingKeys: String, CodingKey {
        case title
        case remoteURL = "url_z"
        case id = "id"
        case dateTaken = "datetaken"
        case height = "height_z"
        case width = "width_z"
        case owner = "ownername"
        case views
        case license
        case latitude
        case longitude
        case accuracy
    }
}
