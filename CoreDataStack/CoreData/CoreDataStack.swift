//
//  CoreDataStack.swift
//  CoreDataStack
//

/// W tym obiekcie będzimy przechowywali podstawowe elementy Core Data Stack.

import Foundation
import CoreData

class CoreDataStack {
    
    private let modelName: String
    
    /// Konstruktor, za pomocą którego będziemy tworzyć nasz Core Data Stack.
    
    init(modelName: String) {
        self.modelName = modelName
    }
    
    /// Tworzymy obiekt NSPersistentContainer, który będzie odpowiedzialny za koordynację pozostałych obiektów z Core Data Stack.
    
    /// Używając parametru 'lazy' mamy pewność, że obiekt zostanie utworzony dopiero w momencie kiedy będzie potrzebny.
    
    private lazy var storeContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: modelName)
        
        container.loadPersistentStores {
            (storeDescription, error) in
            
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        }
        
        return container
    }()
    
    /// Obiekt NSManagedObjectContext będzie obiektem, z którym będziemy pracowali najczęsciej.
    
    lazy var managedContext: NSManagedObjectContext = {
        
        // Korzystamy z NSPersistentContainer zdefiniowanego powyżej.
        
        return self.storeContainer.viewContext
    }()
    
    /// Funkcja pomocnicza do zapisywania zmian dokonanych w bazie danych.
    
    func saveCurrentContext () {
        
        guard managedContext.hasChanges else { return }
        
        do {
            try managedContext.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
}
