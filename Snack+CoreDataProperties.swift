//
//  Snack+CoreDataProperties.swift
//  CoreDataStack
//

/// Te obikety są generowane przez Xcode automatycznie. Wystarczy podświetlić plik UserSnack.xcdatamodel, a następnie wybrać Editor > Create NSManagedObject subclass. W oknie dialogowym można wybrać, na podstawie których instacji mają zostać wygenerowane obiekty pomocnicze. W przypadku tej aplikacji obiekty zostały wygenerowane dla User oraz Snack.

import Foundation
import CoreData


extension Snack {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Snack> {
        return NSFetchRequest<Snack>(entityName: "Snack")
    }

    @NSManaged public var name: String?
    @NSManaged public var user: User?

}
