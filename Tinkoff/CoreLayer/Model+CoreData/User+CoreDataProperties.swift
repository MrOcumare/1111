//
//  User+CoreDataProperties.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 29/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var incrementReq: Int64
    @NSManaged public var name: String?
    @NSManaged public var corenews: NSOrderedSet?

}

// MARK: Generated accessors for corenews
extension User {

    @objc(insertObject:inCorenewsAtIndex:)
    @NSManaged public func insertIntoCorenews(_ value: CoreNews, at idx: Int)

    @objc(removeObjectFromCorenewsAtIndex:)
    @NSManaged public func removeFromCorenews(at idx: Int)

    @objc(insertCorenews:atIndexes:)
    @NSManaged public func insertIntoCorenews(_ values: [CoreNews], at indexes: NSIndexSet)

    @objc(removeCorenewsAtIndexes:)
    @NSManaged public func removeFromCorenews(at indexes: NSIndexSet)

    @objc(replaceObjectInCorenewsAtIndex:withObject:)
    @NSManaged public func replaceCorenews(at idx: Int, with value: CoreNews)

    @objc(replaceCorenewsAtIndexes:withCorenews:)
    @NSManaged public func replaceCorenews(at indexes: NSIndexSet, with values: [CoreNews])

    @objc(addCorenewsObject:)
    @NSManaged public func addToCorenews(_ value: CoreNews)

    @objc(removeCorenewsObject:)
    @NSManaged public func removeFromCorenews(_ value: CoreNews)

    @objc(addCorenews:)
    @NSManaged public func addToCorenews(_ values: NSOrderedSet)

    @objc(removeCorenews:)
    @NSManaged public func removeFromCorenews(_ values: NSOrderedSet)

}
