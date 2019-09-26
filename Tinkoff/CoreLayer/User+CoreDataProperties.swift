//
//  User+CoreDataProperties.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 26/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var news: NSOrderedSet?

}

// MARK: Generated accessors for news
extension User {

    @objc(insertObject:inNewsAtIndex:)
    @NSManaged public func insertIntoNews(_ value: CoreNews, at idx: Int)

    @objc(removeObjectFromNewsAtIndex:)
    @NSManaged public func removeFromNews(at idx: Int)

    @objc(insertNews:atIndexes:)
    @NSManaged public func insertIntoNews(_ values: [CoreNews], at indexes: NSIndexSet)

    @objc(removeNewsAtIndexes:)
    @NSManaged public func removeFromNews(at indexes: NSIndexSet)

    @objc(replaceObjectInNewsAtIndex:withObject:)
    @NSManaged public func replaceNews(at idx: Int, with value: CoreNews)

    @objc(replaceNewsAtIndexes:withNews:)
    @NSManaged public func replaceNews(at indexes: NSIndexSet, with values: [CoreNews])

    @objc(addNewsObject:)
    @NSManaged public func addToNews(_ value: CoreNews)

    @objc(removeNewsObject:)
    @NSManaged public func removeFromNews(_ value: CoreNews)

    @objc(addNews:)
    @NSManaged public func addToNews(_ values: NSOrderedSet)

    @objc(removeNews:)
    @NSManaged public func removeFromNews(_ values: NSOrderedSet)

}
