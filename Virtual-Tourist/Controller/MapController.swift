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
    //vinculacao do map
    @IBOutlet weak var mapView: MKMapView!
    
    //declaracao das varias relacionadas ao coreData
    var locations: [NSManagedObject] = []
    var dataController:DataController!
   
    //variavel da label
    private let label = UILabel()

    //funcao chamada ao abrir app
    override func viewDidLoad() {
        
        let gestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture(gesture:)))
        gestureRecognizer.minimumPressDuration = 0.3
        
        mapView.addGestureRecognizer(gestureRecognizer)
        
        //chama essa funcao
        recuperarLocalizaoDePinosCoreData()
    }
    
    //funcao para recuperar localizacao de pinos do coreData
    func recuperarLocalizaoDePinosCoreData() {
        //chama o appDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //variavel para persistencia
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //faz a requisicao
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Location")
        do {
            //declaracao das variaves segundo datamodel
            locations = try managedContext.fetch(fetchRequest)
            for location in locations {
                let lat: Double = location.value(forKey: "lat") as! Double
                let lon: Double = location.value(forKey: "lon") as! Double
                
                //variaveis
                let coordinate: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: lat, longitude: lon)
                
                self.mapView.setCenter(coordinate, animated: true)
                
                //variavel com atribuicao de valor ao MKPointAnnotation
                let annotation = MKPointAnnotation()
                annotation.coordinate = coordinate
                
                //mapView com adicao do anotation
                self.mapView.addAnnotation(annotation)
                
                
            }
        } catch let error as NSError { //se error retorna mensagem de erro
            print("Could not fetch. \(error), \(error.userInfo)")
        }
    }
    
    //funcao de configuracao do pin
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        //variavel
        let reuseId = "pin"
        
        //variavel referenciando ao reuseID
        var pinView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId) as? MKPinAnnotationView
        
        //condicao que se pin for igual a nil, atribui ao pin algumas configuracoes
        if pinView == nil {
            pinView = MKPinAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
            pinView!.canShowCallout = true //mostra text se for o caso
            pinView!.pinTintColor = .red //pin vermelho
            pinView!.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
        }
        else {
            pinView!.annotation = annotation
        }
        
        return pinView
    }
    
    // funcao para configuracao o toque ao pin
    @objc private func handleLongPressGesture(gesture: UILongPressGestureRecognizer) {
        // quando houver um toque longo em um pin esse bloco pega o toque e converte em acao
        if gesture.state == .began {
            let touch: CGPoint = gesture.location(in: self.mapView)
            
            let coordinate: CLLocationCoordinate2D = self.mapView.convert(touch, toCoordinateFrom: self.mapView)
            
            self.mapView.setCenter(coordinate, animated: true)
            
            let annotation = MKPointAnnotation()
            annotation.coordinate = coordinate
            
            self.mapView.addAnnotation(annotation)
            
            // chama a funcao salvar o pin no coreData, e passa latitude e longitude
            saveFavoritePinToCoredata(latitude: coordinate.latitude, longitude: coordinate.longitude)
        }
    }
    
    //salva o pin de acordo com a latitude e longitude no coreData
    func saveFavoritePinToCoredata(latitude: Double, longitude: Double) {
        // variavel do appDelegate
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        //1 atribui o contexto a persistencia do appDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        //2 variavel da entidade location, que foi declarada no dataModel
        let entity = NSEntityDescription.entity(forEntityName: "Location", in: managedContext)!
        
        let todo = NSManagedObject(entity: entity, insertInto: managedContext)
        
        //3 atributos da tabela criada
        todo.setValue(latitude, forKey: "lat")
        todo.setValue(longitude, forKey: "lon")
        //4 salvar
        do {
            try managedContext.save()
        } catch let error as NSError { //retorna erro se algo falhar
            print("Could not save. \(error), \(error.userInfo)")
        }
    }
    
    // chama a proxima tela
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AlbumPhotos" {
            let albumController = segue.destination as! AlbumController
            albumController.selectedAnnotation = sender as! MKPointAnnotation
        }
    }
    
    //
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        performSegue(withIdentifier: "AlbumPhotos", sender: view.annotation)
    }
    
}
