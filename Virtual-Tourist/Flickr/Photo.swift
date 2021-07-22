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
    let remoteURL: URL
 
    enum CodingKeys: String, CodingKey {
        case title
        case remoteURL = "url_m"
    }
}
