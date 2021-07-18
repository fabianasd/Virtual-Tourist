//
//  Map.swift
//  Virtual-Tourist
//
//  Created by Fabiana Petrovick on 15/07/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//


import Foundation
struct Map: Codable, Equatable {
    
    let firstName: String
    let lastName: String
    let latitude: Double
    let longitude: Double
    let mapString: String
    var mediaURL: String

    enum CodingKeys: String, CodingKey {
        case firstName
        case lastName
        case latitude
        case longitude
        case mapString
        case mediaURL

    }
}
