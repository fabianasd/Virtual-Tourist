//
//  AlbumCollectionViewController.swift
//  Virtual-Tourist
//
//  Created by Fabiana Petrovick on 08/07/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//


import UIKit
import MapKit
import CoreData

class AlbumController: UIViewController {
    @IBOutlet weak var AlbumPhotos: UIStackView!
    
    
    @IBAction func returnMap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
