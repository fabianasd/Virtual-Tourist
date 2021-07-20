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

class AlbumController: UIViewController, MKMapViewDelegate, CLLocationManagerDelegate, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    // @IBOutlet weak var albumPhotos: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    //    @IBOutlet weak var imageFlickr: UIImageView!
    
    var selectedAnnotation: MKPointAnnotation!
    var pagina = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        //        self.collectionView.delegate = self
        buscarImagensNoFlickr()
        //        self.collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        buscarImagensNoFlickr()
        collectionView.reloadData()
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
            // se nao for erro retornar as fotos
            if( flickrResponse != nil) {
                //retornar as fotos
                print("buscarImagensNoFlickr")
                PhotosModel.photoList = (flickrResponse?.photos.photo ?? []) as [Photos]
                self.collectionView.reloadData()
            } else {
                // retornar o erro
                print("Error \(error)")
            }
        }
    }
}

extension AlbumController: UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        buscarImagensNoFlickr()
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
