//
//  Item+CoreDataClass.swift
//  WishList
//
//  Created by Kuala on 2017-04-06.
//  Copyright © 2017 Litroom. All rights reserved.
//

import Foundation
import CoreData

@objc(Item)
public class Item: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        self.created=NSDate()
    }

}
