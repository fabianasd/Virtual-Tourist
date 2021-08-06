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
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var newCollection: UIButton!
    @IBOutlet weak var labelMensage: UILabel!
    @IBOutlet weak var lodingActivity: UIActivityIndicatorView!
    
    var favorites: [NSManagedObject] = []
    var dataController:DataController!
    
    var selectedAnnotation: MKPointAnnotation!
    var pagina = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.delegate = self
        labelMensage.isHidden = false
//        newCollection.isHidden = false
      //  PhotosModel.photoList = []
        retrieveFavoriteFromCoreData()
    }
    
    func retrieveFavoriteFromCoreData() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Favorite")
 
        let predicate = NSPredicate(format: "lat = %@ and lon = %@", String(selectedAnnotation.coordinate.latitude), String(selectedAnnotation.coordinate.longitude))
        fetchRequest.predicate = predicate
        do {
            PhotosModel.photoList = []
            favorites = try managedContext.fetch(fetchRequest)
            print(favorites.count)
            for favorite in favorites {
                let url: String = favorite.value(forKey: "url") as! String
                if(url != nil && url != "") {
                    print(url)
                    labelMensage.isHidden = true
                    PhotosModel.photoList.append(Photo(title: "teste 1", remoteURL: URL(string: url)!))
                }
                else {
                    managedContext.delete(favorite)
                    try managedContext.save()
                }
            }
            collectionView.reloadData()
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
    
    @IBAction func buscarFotosFlickr(_ sender: Any) {
        newCollection.isEnabled = false
        activity(true)
        pagina = pagina + 1
        Flickr.buscarFotosDoFlickrDeAcordoComLatitudeELongitudePorPagina(latitude: selectedAnnotation.coordinate.latitude, longitude: selectedAnnotation.coordinate.longitude, pageNumero: pagina) { flickrResponse, error in
            // se nao for erro retornar as fotos
            if( flickrResponse?.photos.photo != []) {
                //retornar as fotos
//                PhotosModel.photoList = (flickrResponse != nil) ? flickrResponse?.photos.photo as! [Photo] : []
                let photos = (flickrResponse != nil) ? flickrResponse?.photos.photo as! [Photo] : []
                for photo in photos {
                    PhotosModel.photoList.append(photo)
                }
                self.collectionView.reloadData()
            }
            self.activity(false)
            self.newCollection.isEnabled = true
        }
    }
    
}


extension AlbumController: UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return PhotosModel.photoList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "PhotoCell",
            for: indexPath
        ) as! FlickrPhotoCell
        
        let flickrPhoto = PhotosModel.photoList[indexPath.row]
        let url = flickrPhoto.remoteURL
        let data = try? Data(contentsOf: url)
        
        cell.imageView.image = UIImage(data: data!)
        
        return cell
    }
    
    func saveFavoritePinToCoredata(latitude: Double, longitude: Double, url: String) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        //1
        let managedContext = appDelegate.persistentContainer.viewContext
        //2
        let favoriteEntity = NSEntityDescription.entity(forEntityName: "Favorite", in: managedContext)!
        let favoriteObject = NSManagedObject(entity: favoriteEntity, insertInto: managedContext)
        //3
        print(latitude)
        print(longitude)
        favoriteObject.setValue(url, forKey: "url")
        favoriteObject.setValue(String(longitude), forKey: "lon")
        favoriteObject.setValue(String(latitude), forKey: "lat")
        //4
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // handle tap events
        
        let photo: Photo = PhotosModel.photoList[indexPath.row]
        saveFavoritePinToCoredata(latitude: selectedAnnotation.coordinate.latitude, longitude: selectedAnnotation.coordinate.longitude, url: photo.remoteURL.absoluteString)
        
        print("You selected cell #\(indexPath.item)!")
    }
    
    func activity(_ activity: Bool) {
        if activity {
            lodingActivity.startAnimating()
        } else {
            lodingActivity.stopAnimating()
        }
        newCollection.isEnabled = !activity
    }
    
}
