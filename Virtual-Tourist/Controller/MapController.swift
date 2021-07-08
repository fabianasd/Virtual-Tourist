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

class MapViewController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate {
    //
    @IBOutlet weak var mapView: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let locations = hardCodedLocationData()
        
        var annotations = [MKPointAnnotation]()
        
        for dictionary in locations {
            
            let lat = CLLocationDegrees(dictionary["latitude"] as! Double)
            let long = CLLocationDegrees(dictionary["longitude"] as! Double)
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)

            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            annotations.append(annotation)
        }
        
        self.mapView.addAnnotations(annotations)
        
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
    
    //
    //    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView)
    //    {
    //        if let annotationTitle = view.annotation?.title
    //        {
    //            print("User tapped on annotation with title: \(annotationTitle!)")
    //        }
    //    }
    
    func addToMap(locations: [MapModel]) {
        var annotations = [MKPointAnnotation]()
        
        for map in locations {
            
            
            let lat = CLLocationDegrees(map.latitude as! Double)
            let long = CLLocationDegrees(map.longitude as! Double)
            
            let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            annotations.append(annotation)
        }
        
        self.mapView.addAnnotations(annotations)
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if control == view.rightCalloutAccessoryView {
            let app = UIApplication.shared
            if let toOpen = view.annotation?.subtitle! {
                if let url =  URL(string: toOpen){
                    UIApplication.shared.open(url, options: [:])
                } else {
                    // self.showAlert(title: "Alert", message: "Not information cadastred")
                    print("aqui no mapView")
                }
            }
        }
    }

    func hardCodedLocationData() -> [[String : Any]] {
        return [
            [
                "latitude" : 28.1461248,
                "longitude" : -82.75676799999999
            ],
            [
                "latitude" : 35.1740471,
                "longitude" : -79.3922539
            ]
        ]
    }
}
