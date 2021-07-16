//
//  Flickr.swift
//  Virtual-Tourist
//
//  Created by Fabiana Petrovick on 15/07/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import Foundation
import UIKit

class Flickr {
    
    struct Auth {
        static var latitude = ""
        static var longitude = ""
        static var radius = ""
        static var perPage = ""
        static var pageNum = ""
    }
    
    enum Endpoints {
        static let base = "https://www.flickr.com/services/rest/?method=flickr.photos.search"
        
        case getFlickr
        
        var stringValue: String {
            switch self {
            case .getFlickr: return Endpoints.base + "&api_key=\(FlickrAPI.apiKey)" +
                "&lat=\(Flickr.Auth.latitude)" +
                "&lon=\(Flickr.Auth.longitude)" +
                "&radius=\(Flickr.Auth.radius)" +
                "&per_page=\(Flickr.Auth.perPage)" +
                "&page=\(Flickr.Auth.pageNum)" +
                "&format=json&nojsoncallback=1&extras=url_m"
            }
        }
        var url: URL {
            return URL(string: stringValue)!
        }
    }
    
    class func getFlickr(completion: @escaping ([Map], Bool, Error?) -> Void) {
        let request = URLRequest(url: Endpoints.getFlickr.url)
        print(" aqui a url) \(request)")
           let session = URLSession.shared
           let task = session.dataTask(with: request) { data, response, error in
           let task = session.dataTask(with: request) { data, response, error  in
               if error != nil { // Handle error...
                   DispatchQueue.main.async {
                    //   completion(false, error)
                       completion([], false, error)
                   }
               }
               print(String(data: data!, encoding: .utf8)!)

               let decoder = JSONDecoder()

               do {
                   let responseObject = try decoder.decode(FlickrPhotosResponse.self, from: data!)
                   DispatchQueue.main.async {
                    completion(responseObject.results, true, nil)
                   }
               }
               catch {
                   print(error)
                   //... falhar
                   DispatchQueue.main.async {
                       completion([], false, error)
                   }
               }

           }
           task.resume()
       }

    }
}
