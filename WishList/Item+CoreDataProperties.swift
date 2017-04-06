//
//  Item+CoreDataProperties.swift
//  WishList
//
//  Created by Kuala on 2017-04-06.
//  Copyright © 2017 Litroom. All rights reserved.
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var title: String?
    @NSManaged public var created: NSDate?
    @NSManaged public var details: String?
    @NSManaged public var image: Image?
    @NSManaged public var store: Store?
    @NSManaged public var itemType: ItemType?

}
