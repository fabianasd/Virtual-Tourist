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

class MapController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, NSFetchedResultsControllerDelegate {
    @IBOutlet weak var mapView: MKMapView!
    
    var locations: [NSManagedObject] = []
    var dataController:DataController!
    
    private let label = UILabel()
    
    override func viewDidLoad() {
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(gesture:)))
        gestureRecognizer.minimumPressDuration = 0.3
        
        mapView.addGestureRecognizer(gestureRecognizer)
        
        recuperarLocalizaoDePinosCoreData()
    }
    
    func recuperarLocalizaoDePinosCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Location")
        do {
            locations = try managedContext.fetch(fetchRequest)
            for location in locations {
                let lat: Double = location.value(forKey: "lat") as! Double
                let lon: Double = location.value(forKey: "lon") as! Double
                
                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                
                self.mapView.setCenter(coordinate, animated: true)
                
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                
                self.mapView.addAnnotation(annotation)
                
                
            }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
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
            
            saveFavoritePinToCoredata(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
    }
    
    func saveFavoritePinToCoredata(latitude: Double, longitude: Double) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Location", in: managedContext)!
        
        let todo = NSManagedObject(entity: entity, insertInto: managedContext)
        
        todo.setValue(latitude, forKey: "lat")
        todo.setValue(longitude, forKey: "lon")
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
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
