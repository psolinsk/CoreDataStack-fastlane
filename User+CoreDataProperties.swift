//
//  User+CoreDataProperties.swift
//  CoreDataStack
//

/// Te obikety są generowane przez Xcode automatycznie. Wystarczy podświetlić plik UserSnack.xcdatamodel, a następnie wybrać Editor > Create NSManagedObject subclass. W oknie dialogowym można wybrać, na podstawie których instacji mają zostać wygenerowane obiekty pomocnicze. W przypadku tej aplikacji obiekty zostały wygenerowane dla User oraz Snack.

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var snacks: NSOrderedSet?

}

// MARK: Generated accessors for snacks
extension User {

    @objc(insertObject:inSnacksAtIndex:)
    @NSManaged public func insertIntoSnacks(_ value: Snack, at idx: Int)

    @objc(removeObjectFromSnacksAtIndex:)
    @NSManaged public func removeFromSnacks(at idx: Int)

    @objc(insertSnacks:atIndexes:)
    @NSManaged public func insertIntoSnacks(_ values: [Snack], at indexes: NSIndexSet)

    @objc(removeSnacksAtIndexes:)
    @NSManaged public func removeFromSnacks(at indexes: NSIndexSet)

    @objc(replaceObjectInSnacksAtIndex:withObject:)
    @NSManaged public func replaceSnacks(at idx: Int, with value: Snack)

    @objc(replaceSnacksAtIndexes:withSnacks:)
    @NSManaged public func replaceSnacks(at indexes: NSIndexSet, with values: [Snack])

    @objc(addSnacksObject:)
    @NSManaged public func addToSnacks(_ value: Snack)

    @objc(removeSnacksObject:)
    @NSManaged public func removeFromSnacks(_ value: Snack)

    @objc(addSnacks:)
    @NSManaged public func addToSnacks(_ values: NSOrderedSet)

    @objc(removeSnacks:)
    @NSManaged public func removeFromSnacks(_ values: NSOrderedSet)

}
