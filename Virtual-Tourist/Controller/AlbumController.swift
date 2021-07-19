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

class AlbumController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // @IBOutlet weak var albumPhotos: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    //    @IBOutlet weak var imageFlickr: UIImageView!
    
    var selectedAnnotation: MKPointAnnotation!
    var pagina = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        self.collectionView.delegate = self
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
            if( error != nil) {
                PhotosModel.photoList = FlickrResponse(from: Photos as! Decoder)
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return PhotosModel.photoList.count
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotosModel.photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("Item da lista:\(indexPath.row)")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath as IndexPath)
        
        // Use the outlet in our custom class to get a reference to the UILabel in the cell
        //  cell.myLabel.text = self.items[indexPath.row] // The row value is the same as the index of the desired text within the array.
        let flickrPhoto = PhotosModel.photoList[indexPath.row]
        
        //        cell.imageView.image = flickrPhoto
        cell.backgroundColor = UIColor.black // make cell more visible in our example project
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        print("You selected cell #\(indexPath.item)!")
    }
}
