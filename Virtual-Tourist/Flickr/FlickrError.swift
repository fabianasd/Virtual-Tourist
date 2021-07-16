//
//  FlickrError.swift
//  Virtual-Tourist
//
//  Created by Fabiana Petrovick on 13/07/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import Foundation

enum FlickrError: Error {
  case parsing(description: String)
  case network(description: String)
}
