//
//  Shopkin.swift
//  Shopkins List
//
//  Created by Andrew Keym on 3/19/15.
//  Copyright (c) 2015 Andrew Keym. All rights reserved.
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
    @NSManaged var own: Bool
    @NSManaged var wishlist: Bool

}
