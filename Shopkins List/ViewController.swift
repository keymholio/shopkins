//
//  ViewController.swift
//  Shopkins List
//
//  Created by Andrew Keym on 3/9/15.
//  Copyright (c) 2015 Andrew Keym. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView?
    var error: NSError?
    var shopkins = [NSManagedObject]()
    let context =  (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController!.navigationBar.translucent = false
        self.navigationController!.navigationBar.barTintColor = UIColor(red:236/255, green:5/255,blue:156/255,alpha:1.0)
    
        // remove all of the core Shopkin data
        //self.deleteAll()
        
        // load in default data
        //self.saveShopkin("1-001", name: "Apple Blossum", rarity: "common", finish: "none", category: "Fruit & Veg", season: 1, own: false, wishlist: false)
        //self.saveShopkin("1-002", name: "Rockin' Broc", rarity: "common", finish: "none", category: "Fruit & Veg", season: 1, own: false, wishlist: false)
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopkins.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let shopkin = shopkins[indexPath.row]
        let own = shopkin.valueForKey("own") as Bool
        let sk_id = shopkin.valueForKey("id") as String?
        let rarity = shopkin.valueForKey("rarity") as String?
        let cell: ColViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as ColViewCell
        
        cell.nameCell!.text = shopkin.valueForKey("name") as String?
        
        cell.imgCell.image = UIImage(named: sk_id!)
        
        if (own) {
            cell.checkCell.image = UIImage(named: "cb_" + rarity! + "-checked")
        } else {
            cell.checkCell.image = UIImage(named: "cb_" + rarity!)
        }
      
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let selected = shopkins[indexPath.row] as Shopkin
        let request = NSFetchRequest(entityName: "Shopkin")
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Shopkin")
        let fetchedResults = context!.executeFetchRequest(fetchRequest, error: &error) as [Shopkin]?
        
        // this doesn't seem like the most efficient way to do this... but it works
        // loops through the fetched results matching the selected id and changing
        // the "own" attribute
        if let results = fetchedResults {
            for result in results {
                if (result.id == selected.id) {
                    if (result.own) {
                        result.own = false
                    } else {
                        result.own = true
                    }
                }
            }
        }
        
        if !context!.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        
        collectionView.reloadData()
    }
    
    func saveShopkin(id: String, name: String, rarity: String, finish: String, category: String,
        season: NSNumber, own: Bool, wishlist: Bool ) {

        let entity =  NSEntityDescription.entityForName("Shopkin", inManagedObjectContext: context!)
        let shopkin = NSManagedObject(entity: entity!, insertIntoManagedObjectContext:context)

        shopkin.setValue(name, forKey: "name")
        shopkin.setValue(id, forKey: "id")
        shopkin.setValue(rarity, forKey: "rarity")
        shopkin.setValue(finish, forKey: "finish")
        shopkin.setValue(category, forKey: "category")
        shopkin.setValue(season, forKey: "season")
        shopkin.setValue(own, forKey: "own")
        shopkin.setValue(wishlist, forKey: "wishlist")

        if !context!.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }

        shopkins.append(shopkin)
    }
    
    func deleteAll() {
        
        let request = NSFetchRequest(entityName: "Shopkin")
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Shopkin")
        let fetchedResults = context!.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        // loop through and delete the Shopkin objects in Core Data
        if let results = fetchedResults {
            for result in results {
                context!.deleteObject(result)
            }
        }
        
        context!.save(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let fetchRequest = NSFetchRequest(entityName:"Shopkin")
        let fetchedResults = context!.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            shopkins = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
}

