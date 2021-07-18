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
    
    struct AtributosDeRequisicaoDoFlickr {
        static var radius = ""
        static var perPage = "3"
    }
    
    class func montarUrlParaMontarServicoFlickr(latitude: Double, longitude: Double, pageNumero: Int) -> URL {
        let base = "https://www.flickr.com/services/rest/?method=flickr.photos.search"
        let urlComTodosOsParametros: String = base + "&api_key=\(FlickrAPI.apiKey)" +
            "&lat=\(latitude)" +
            "&lon=\(longitude)" +
            "&radius=\(Flickr.AtributosDeRequisicaoDoFlickr.radius)" +
            "&per_page=\(Flickr.AtributosDeRequisicaoDoFlickr.perPage)" +
            "&page=\(pageNumero)" +
        "&format=json&nojsoncallback=1&extras=url_m"
        return URL(string: urlComTodosOsParametros)!
    }
    
    class func buscarFotosDoFlickrDeAcordoComLatitudeELongitudePorPagina(latitude: Double, longitude: Double, pageNumero: Int, completion: @escaping (FlickrResponse?, Error?) -> Void) {
        let request = URLRequest(url: Flickr.montarUrlParaMontarServicoFlickr(latitude: latitude, longitude: longitude, pageNumero: pageNumero))
        print(" aqui a url) \(request)")
        let session = URLSession.shared
        let task = session.dataTask(with: request) { data, response, error in
            if error != nil { // Handle error...
                DispatchQueue.main.async {
                    //   completion(false, error)
                    completion(nil, error)
                }
            }
            print(String(data: data!, encoding: .utf8)!)
            
            let decoder = JSONDecoder()
            
            do {
                let responseObject = try decoder.decode(FlickrResponse.self, from: data!)
                DispatchQueue.main.async {
                    completion(responseObject, nil)
                }
            }
            catch {
                print(error)
                //... falhar
                DispatchQueue.main.async {
                    completion(nil, error)
                }
            }
            
        }
        task.resume()
    }
}
