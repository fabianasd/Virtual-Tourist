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

class AlbumController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var albumPhotos: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    var editingMap:MapModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
    }
    
    
    
    @IBAction func returnMap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        addPinToMap()
    }
    // MARK: - MKMapViewDelegate
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        
        let reuseId = "pin"
        
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true
            pinView!.pinTintColor = .red
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    func addPinToMap() {
        //        let lat = CLLocationDegrees(editingMap.latitude as! Double)
        //        let long = CLLocationDegrees(editingMap.longitude as! Double)
        //
        //        let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
        
        //        let first = editingMap.firstName as! String
        //        let last = editingMap.lastName as! String
        //        let mediaURL = editingMap.mediaURL as! String
        
        let annotation = MKPointAnnotation()
        //        annotation.coordinate = coordinate
        
        self.mapView.addAnnotation(annotation)
    //    self.mapView.showAnnotations(self.mapView.annotations, animated: true)
    }
}
