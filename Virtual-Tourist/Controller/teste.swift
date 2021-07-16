//
//  teste.swift
//  Virtual-Tourist
//
//  Created by Fabiana Petrovick on 15/07/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import UIKit

class teste: UIViewController {

    @IBAction func btn(_ sender: Any) {
           print("aqi")
           
           Flickr.getFlickr(completion:handleStudentResponse(maps:success:error:))
       }
       
       func handleStudentResponse(maps: [Map], success: Bool, error: Error?) {
           if(success) {
               print("aqui")
           } else {
               print("aquiiiii")
           }
       }
}
