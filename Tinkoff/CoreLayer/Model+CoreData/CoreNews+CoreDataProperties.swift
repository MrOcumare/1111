//
//  CoreNews+CoreDataProperties.swift
//  Tinkoff
//
//  Created by Mr.Ocumare on 27/09/2019.
//  Copyright © 2019 Ilya Ocumare. All rights reserved.
//
//

import Foundation
import CoreData


extension CoreNews {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CoreNews> {
        return NSFetchRequest<CoreNews>(entityName: "CoreNews")
    }

    @NSManaged public var date: String?
    @NSManaged public var id: String?
    @NSManaged public var slug: String?
    @NSManaged public var text: String?
    @NSManaged public var tittle: String?
    @NSManaged public var viewCount: Int16
    @NSManaged public var user: User?

}
