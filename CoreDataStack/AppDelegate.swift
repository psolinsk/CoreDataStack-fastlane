//
//  AppDelegate.swift
//  CoreDataStack
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    /// To jest punkt starotowy dla naszego Core Data Stack. Podczas tworzenia obiektu podajemy nazwę dla naszego modelu danych.

    lazy var coreDataStack = CoreDataStack(modelName: "UserSnacks")

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        guard let navigationVC =
            window?.rootViewController as? UINavigationController,
            let mainVC =
            navigationVC.topViewController as? MainVC else {
                return true
        }
        
        // W tym miejscu przekazujemy obiekt NSManagedObjectContext do naszego startwego ViewController o nazwie MainVC.
        
        mainVC.managedContext = coreDataStack.managedContext
        
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        // Kiedy aplikacja będzie przechodziła do trybu background to warto zapisać nasze dane.
        
        coreDataStack.saveCurrentContext()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        // Kiedy aplikacja będzie zamykana to również warto zapisać dane.
        
        coreDataStack.saveCurrentContext()
    }
}

