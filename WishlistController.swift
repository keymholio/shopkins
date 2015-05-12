//
//  WishlistController.swift
//  Shopkins List
//
//  Created by Andrew Keym on 5/5/15.
//  Copyright (c) 2015 Andrew Keym. All rights reserved.
//

import UIKit
import CoreData

class WishlistController: ShopkinsController {
    
    override var wishlist: Bool { get { return true } }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let shopkin: Shopkin
        shopkin = shopkins[indexPath.row] as! Shopkin
        
        let wish = shopkin.valueForKey("wishlist") as! Bool
        let sk_id = shopkin.valueForKey("id") as! String?
        let rarity = shopkin.valueForKey("rarity") as! String?
        let cell: ColViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ColViewCell
        
        cell.nameCell!.text = shopkin.valueForKey("name") as! String?
        cell.idCell.text = "#" + sk_id!
        cell.imgCell.image = UIImage(named: sk_id!)
        
        if (wish) {
            cell.checkCell.image = UIImage(named: "star-icon-on")
        } else {
            cell.checkCell.image = UIImage(named: "star-icon-off")
        }
        
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let selected: Shopkin
        selected = shopkins[indexPath.row] as! Shopkin
        
        if (selected.wishlist) {
            selected.wishlist = false
        } else {
            selected.wishlist = true
        }
        
        if !context!.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        collectionView.reloadData()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let req = NSFetchRequest(entityName:"Shopkin")
        req.predicate = NSPredicate(format: "own == 0")
        let reqResults = context!.executeFetchRequest(req, error: &error) as! [NSManagedObject]?
        
        if let results = reqResults {
            shopkins = results
            allShopkins = shopkins
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }

}
