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
    var tableData: [String] = ["Apple Blossum", "Rockin' Broc", "Apple Blossum", "Rockin' Broc", "Apple Blossum", "Rockin' Broc", "Apple Blossum", "Rockin' Broc", "Apple Blossum", "Rockin' Broc", "Apple Blossum", "Rockin' Broc"]
    var tableImages: [String] = ["1-001", "1-002", "1-001", "1-002", "1-001", "1-002", "1-001", "1-002", "1-001", "1-002", "1-001", "1-002"]
    
    let managedObjectContext =  (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        self.navigationController!.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController!.navigationBar.translucent = false
        self.navigationController!.navigationBar.barTintColor = UIColor(red:236/255, green:5/255,blue:156/255,alpha:1.0)
    
        self.saveShopkin("1-001", name: "Apple Blossum")
    
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopkins.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let shopkin = shopkins[indexPath.row]
        
        
        //println(fetchResults)
        
        let cell: ColViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as ColViewCell
        
        cell.nameCell!.text = shopkin.valueForKey("name") as String?
        let img_id = shopkin.valueForKey("id") as String?
        cell.imgCell.image = UIImage(named: img_id!)
        
        //cell.nameCell.text = fetchResults[indexPath.row].name
        //cell.imgCell.image = UIImage(named: fetchResults[indexPath.row].id)
      
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        println("Cell \(indexPath.row) selected")
    }
    
    func setUpFlowLayout(flow:UICollectionViewFlowLayout) {
        flow.estimatedItemSize = CGSizeMake(400,30)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveShopkin(id: String, name: String) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        
        let managedContext = appDelegate.managedObjectContext!
        
        //2
        let entity =  NSEntityDescription.entityForName("Shopkin",
            inManagedObjectContext:
            managedContext)
        
        let shopkin = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        
        //3
        shopkin.setValue(name, forKey: "name")
        shopkin.setValue(id, forKey: "id")
        
        //4
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }  
        //5
        shopkins.append(shopkin)
    }


}

