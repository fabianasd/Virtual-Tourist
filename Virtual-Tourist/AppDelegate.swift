//
//  AppDelegate.swift
//  Virtual-Tourist
//
//  Created by Fabiana Petrovick on 19/06/21.
//  Copyright © 2021 Fabiana Petrovick. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    let dataController = DataController(modelName: "VirtualTourist")
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        dataController.load()
        
        let navigationController = window?.rootViewController as! UINavigationController
        let mapview = navigationController.topViewController as! MapController
        mapview.dataController = (UIApplication.shared.delegate as? AppDelegate)?.dataController
        
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle
   
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        saveViewContext()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        saveViewContext()
    }
    
    //metodo auxiliar, que chama save no viewContext do DataController
    func saveViewContext(){
        try? dataController.viewContext.save()
    }
    
}

