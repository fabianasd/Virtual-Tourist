//
//  MapController.swift
//  Virtual-Tourist
//
//  Created by Fabiana Petrovick on 08/07/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import UIKit
import MapKit
import CoreData

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    private let label = UILabel()
    
    override func viewDidLoad() {
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(gesture:)))
        gestureRecognizer.minimumPressDuration = 0.3
        
        mapView.addGestureRecognizer(gestureRecognizer)
        
    }
    
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
    
    @objc private func handleLongPressGesture(gesture: UILongPressGestureRecognizer) {
        if gesture.state == .began {
            let touch: CGPoint = gesture.location(in: self.mapView)
            
            let coordinate: CLLocationCoordinate2D = self.mapView.convert(touch, toCoordinateFrom: self.mapView)
            
            self.mapView.setCenter(coordinate, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            self.mapView.addAnnotation(annotation)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AlbumPhotos" {
            let albumController = segue.destination as! AlbumController
            albumController.selectedAnnotation = sender as! MKPointAnnotation
        }
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        performSegue(withIdentifier: "AlbumPhotos", sender: view.annotation)
    }
    
}
