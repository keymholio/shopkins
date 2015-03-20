//
//  ViewController.swift
//  Shopkins List
//
//  Created by Andrew Keym on 3/9/15.
//  Copyright (c) 2015 Key Lime Industries. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var collectionView: UICollectionView?
    
    var shopkins = [NSManagedObject]()
    //var tableData: [String] = ["Apple Blossum", "Rockin' Broc", "Apple Blossum", "Rockin' Broc", "Apple Blossum", "Rockin' Broc", "Apple Blossum", "Rockin' Broc", "Apple Blossum", "Rockin' Broc", "Apple Blossum", "Rockin' Broc"]
    //var tableImages: [String] = ["1-001", "1-002", "1-001", "1-002", "1-001", "1-002", "1-001", "1-002", "1-001", "1-002", "1-001", "1-002"]
    
    let managedObjectContext =  (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.navigationController!.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController!.navigationBar.translucent = false
        self.navigationController!.navigationBar.barTintColor = UIColor(red:236/255, green:5/255,blue:156/255,alpha:1.0)
    
        // remove all of the core Shopkin data
        //self.deleteAll()
        
        // load in default data
        //self.saveShopkin("1-001", name: "Apple Blossum")
        //self.saveShopkin("1-002", name: "Rockin' Broc")
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopkins.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let shopkin = shopkins[indexPath.row]
        
        
        let cell: ColViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as ColViewCell
        
        cell.nameCell!.text = shopkin.valueForKey("name") as String?
        let sk_id = shopkin.valueForKey("id") as String?
        if (sk_id != nil) {
            cell.imgCell.image = UIImage(named: sk_id!)
        }
      
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Cell \(indexPath.row) selected")
    }
    
    func saveShopkin(id: String, name: String) {

        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let context = appDelegate.managedObjectContext!

        let entity =  NSEntityDescription.entityForName("Shopkin",
            inManagedObjectContext:
            context)
        
        let shopkin = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:context)

        shopkin.setValue(name, forKey: "name")
        shopkin.setValue(id, forKey: "id")

        var error: NSError?
        if !context.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }

        shopkins.append(shopkin)
    }
    
    func deleteAll() {
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let context = appDelegate.managedObjectContext!
        
        let request = NSFetchRequest(entityName: "Shopkin")
        var error: NSError?
        
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Shopkin")
        let fetchedResults = context.executeFetchRequest(fetchRequest, error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            for result in results {
                context.deleteObject(result)
            }
        }
        
        context.save(nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"Shopkin")
        
        var error: NSError?
        
        let fetchedResults =
        managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        
        if let results = fetchedResults {
            shopkins = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
    



}

