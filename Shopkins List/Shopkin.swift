//
//  Shopkin.swift
//  Shopkins List
//
//  Created by Andrew Keym on 3/19/15.
//  Copyright (c) 2015 Key Lime Industries. All rights reserved.
//

import Foundation
import CoreData

class Shopkin: NSManagedObject {

    @NSManaged var id: String
    @NSManaged var name: String
    @NSManaged var rarity: String
    @NSManaged var finish: String
    @NSManaged var category: String
    @NSManaged var season: NSNumber
    @NSManaged var own: NSNumber
    @NSManaged var wishlist: NSNumber

}
