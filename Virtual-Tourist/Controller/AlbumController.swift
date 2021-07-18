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
    
    var selectedAnnotation: MKPointAnnotation!
    var pagina = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        buscarImagensNoFlickr()
    }
    
    @IBAction func returnMap(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func mapViewDidFinishRenderingMap(_ mapView: MKMapView, fullyRendered: Bool) {
        addPinToMap(annotation: selectedAnnotation)
        centerOnCurrentPin()
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
    
    func addPinToMap(annotation: MKPointAnnotation) {
        self.mapView.addAnnotation(annotation)
    }
    
    func centerOnCurrentPin() {
        self.mapView.setCenter(selectedAnnotation.coordinate, animated: true)
    }
    
    func buscarImagensNoFlickr() {
        Flickr.buscarFotosDoFlickrDeAcordoComLatitudeELongitudePorPagina(latitude: selectedAnnotation.coordinate.latitude, longitude: selectedAnnotation.coordinate.longitude, pageNumero: pagina) { flickrResponse, error in
            
        }
    }
    
}
