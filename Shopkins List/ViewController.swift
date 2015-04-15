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
    let context =  (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.navigationBar.barStyle = UIBarStyle.Black
        self.navigationController!.navigationBar.translucent = false
        self.navigationController!.navigationBar.barTintColor = UIColor(red:236/255, green:5/255,blue:156/255,alpha:1.0)
    
        // remove all of the core Shopkin data
        //self.deleteAll()
        
        // load in default data
        //self.loadDefaults()
        
    }
    
    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return shopkins.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let shopkin = shopkins[indexPath.row]
        let own = shopkin.valueForKey("own") as! Bool
        let sk_id = shopkin.valueForKey("id") as! String?
        let rarity = shopkin.valueForKey("rarity") as! String?
        let cell: ColViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("Cell", forIndexPath: indexPath) as! ColViewCell
        
        cell.nameCell!.text = shopkin.valueForKey("name") as! String?
        cell.idCell.text = "#" + sk_id!
        cell.imgCell.image = UIImage(named: sk_id!)
        
        if (own) {
            cell.checkCell.image = UIImage(named: "cb_" + rarity! + "-checked")
        } else {
            cell.checkCell.image = UIImage(named: "cb_" + rarity!)
        }
      
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let selected = shopkins[indexPath.row] as! Shopkin
        let request = NSFetchRequest(entityName: "Shopkin")
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Shopkin")
        let fetchedResults = context!.executeFetchRequest(fetchRequest, error: &error) as! [Shopkin]?
        
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
    
    func loadDefaults() {
        self.saveShopkin("1-001", name: "Apple Blossum", rarity: "common", finish: "none", category: "Fruit & Veg", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-002", name: "Rockin' Broc", rarity: "common", finish: "none", category: "Fruit & Veg", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-003", name: "Strawberry Kiss", rarity: "rare", finish: "none", category: "Fruit & Veg", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-004", name: "Pineapple Crush", rarity: "common", finish: "none", category: "Fruit & Veg", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-005", name: "Melonie Pips", rarity: "ultra_rare", finish: "none", category: "Fruit & Veg", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-006", name: "Miss Mushy-Moo", rarity: "common", finish: "none", category: "Fruit & Veg", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-007", name: "Posh Pear", rarity: "common", finish: "none", category: "Fruit & Veg", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-008", name: "Apple Blossom", rarity: "common", finish: "none", category: "Fruit & Veg", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-009", name: "Rockin' Broc", rarity: "common", finish: "none", category: "Fruit & Veg", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-010", name: "Strawberry Kiss", rarity: "rare", finish: "none", category: "Fruit & Veg", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-011", name: "Pineapple Crush", rarity: "common", finish: "none", category: "Fruit & Veg", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-012", name: "Melonie Pips", rarity: "ultra_rare", finish: "none", category: "Fruit & Veg", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-013", name: "Miss Mushy-Moo", rarity: "common", finish: "none", category: "Fruit & Veg", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-014", name: "Posh Pear", rarity: "common", finish: "none", category: "Fruit & Veg", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-015", name: "Tommy Ketchup", rarity: "common", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-016", name: "Nutty Butter", rarity: "rare", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-017", name: "Peppe Pepper", rarity: "common", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-018", name: "Sally Shakes", rarity: "rare", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-019", name: "Sugar Lump", rarity: "ultra_rare", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-020", name: "Breaky Crunch", rarity: "ultra_rare", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-021", name: "Alpha Soup", rarity: "rare", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-022", name: "Gran Jam", rarity: "common", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-023", name: "Coolio", rarity: "common", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-024", name: "Tommy Ketchup", rarity: "common", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-025", name: "Nutty Butter", rarity: "rare", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-026", name: "Peppe Pepper", rarity: "common", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-027", name: "Sally Shakes", rarity: "rare", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-028", name: "Sugar Lump", rarity: "ultra_rare", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-029", name: "Breaky Crunch", rarity: "ultra_rare", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-030", name: "Alpha Soup", rarity: "rare", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-031", name: "Gran Jam", rarity: "common", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-032", name: "Coolio", rarity: "common", finish: "none", category: "Pantry", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-033", name: "Bread Head", rarity: "common", finish: "none", category: "Bakery", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-034", name: "Creamy Bun-Bun", rarity: "rare", finish: "none", category: "Bakery", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-035", name: "D'lish Donut", rarity: "ultra_rare", finish: "none", category: "Bakery", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-036", name: "Cheese Kate", rarity: "common", finish: "none", category: "Bakery", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-037", name: "Mini Muffin", rarity: "common", finish: "none", category: "Bakery", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-038", name: "Flutter Cake", rarity: "common", finish: "none", category: "Bakery", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-039", name: "Kooky Cookie", rarity: "ultra_rare", finish: "none", category: "Bakery", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-040", name: "Bread Head", rarity: "common", finish: "none", category: "Bakery", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-041", name: "Creamy Bun-Bun", rarity: "rare", finish: "none", category: "Bakery", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-042", name: "D'lish Donut", rarity: "ultra_rare", finish: "none", category: "Bakery", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-043", name: "Cheese Kate", rarity: "common", finish: "none", category: "Bakery", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-044", name: "Mini Muffin", rarity: "common", finish: "none", category: "Bakery", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-045", name: "Flutter Cake", rarity: "common", finish: "none", category: "Bakery", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-046", name: "Kooky Cookie", rarity: "ultra_rare", finish: "none", category: "Bakery", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-047", name: "Bubbles", rarity: "rare", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-048", name: "Candy Kisses", rarity: "rare", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-049", name: "Le'Quorice", rarity: "rare", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-050", name: "Cheeky Chocolate", rarity: "rare", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-051", name: "Candi Cotton", rarity: "ultra_rare", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-052", name: "Lolli Poppins", rarity: "rare", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-053", name: "Mandy Candy", rarity: "ultra_rare", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-054", name: "Jelly B", rarity: "rare", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-055", name: "Miss Twist", rarity: "common", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-056", name: "Bubbles", rarity: "rare", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-057", name: "Candy Kisses", rarity: "rare", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-058", name: "Le'Quorice", rarity: "rare", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-059", name: "Cheeky Chocolate", rarity: "rare", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-060", name: "Candi Cotton", rarity: "ultra_rare", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-061", name: "Lolli Poppins", rarity: "rare", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-062", name: "Mandy Candy", rarity: "ultra_rare", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-063", name: "Jelly B", rarity: "rare", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-064", name: "Miss Twist", rarity: "common", finish: "none", category: "Sweet Treats", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-065", name: "Chee Zee", rarity: "common", finish: "none", category: "Dairy", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-066", name: "Swiss Miss", rarity: "common", finish: "none", category: "Dairy", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-067", name: "Spilt Milk", rarity: "rare", finish: "none", category: "Dairy", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-068", name: "Ghurty", rarity: "rare", finish: "none", category: "Dairy", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-069", name: "Millie Shake", rarity: "ultra_rare", finish: "none", category: "Dairy", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-070", name: "Flava Ava", rarity: "common", finish: "none", category: "Dairy", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-071", name: "Dollops", rarity: "common", finish: "none", category: "Dairy", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-072", name: "Googy", rarity: "common", finish: "none", category: "Dairy", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-073", name: "Chee Zee", rarity: "common", finish: "none", category: "Dairy", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-074", name: "Swiss Miss", rarity: "common", finish: "none", category: "Dairy", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-075", name: "Spilt Milk", rarity: "rare", finish: "none", category: "Dairy", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-076", name: "Ghurty", rarity: "rare", finish: "none", category: "Dairy", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-077", name: "Millie Shake", rarity: "ultra_rare", finish: "none", category: "Dairy", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-078", name: "Flava Ava", rarity: "common", finish: "none", category: "Dairy", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-079", name: "Dollops", rarity: "common", finish: "none", category: "Dairy", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-080", name: "Googy", rarity: "common", finish: "none", category: "Dairy", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-081", name: "Crispy Chip", rarity: "rare", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-082", name: "Pretz-elle", rarity: "rare", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-083", name: "Wobbles", rarity: "common", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-084", name: "Rainbow Bite", rarity: "common", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-085", name: "Wishes", rarity: "ultra_rare", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-086", name: "Frank Furter", rarity: "common", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-087", name: "Little Sipper", rarity: "common", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-088", name: "Fairy Crumbs", rarity: "common", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-089", name: "Cheezey B", rarity: "rare", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-090", name: "Soda Pops", rarity: "ultra_rare", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-091", name: "Crispy Chip", rarity: "rare", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-092", name: "Pretz-elle", rarity: "rare", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-093", name: "Wobbles", rarity: "common", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-094", name: "Rainbow Bite", rarity: "common", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-095", name: "Wishes", rarity: "ultra_rare", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-096", name: "Frank Furter", rarity: "common", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-097", name: "Little Sipper", rarity: "common", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-098", name: "Fairy Crumbs", rarity: "common", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-099", name: "Cheezey B", rarity: "rare", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-100", name: "Soda Pops", rarity: "ultra_rare", finish: "none", category: "Party Food", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-101", name: "Scrubs", rarity: "common", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-102", name: "Lippy Lips", rarity: "rare", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-103", name: "Curly", rarity: "common", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-104", name: "Shampy", rarity: "common", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-105", name: "Silky", rarity: "common", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-106", name: "Bubble Tubs", rarity: "ultra_rare", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-107", name: "Chap-Elli", rarity: "rare", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-108", name: "Polly Polish", rarity: "ultra_rare", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-109", name: "Suds", rarity: "common", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-110", name: "Toofs", rarity: "ultra_rare", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-111", name: "Scrubs", rarity: "common", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-112", name: "Lippy Lips", rarity: "rare", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-113", name: "Curly", rarity: "common", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-114", name: "Shampy", rarity: "common", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-115", name: "Silky", rarity: "common", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-116", name: "Bubble Tubs", rarity: "ultra_rare", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-117", name: "Chap-Elli", rarity: "rare", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-118", name: "Polly Polish", rarity: "ultra_rare", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-119", name: "Suds", rarity: "common", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-120", name: "Toofs", rarity: "ultra_rare", finish: "none", category: "Health & Beauty", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-121", name: "Ice Cream Dream", rarity: "special", finish: "none", category: "Frozen", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-122", name: "Popsi Cool", rarity: "special", finish: "none", category: "Frozen", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-123", name: "Yo-Chi", rarity: "special", finish: "none", category: "Frozen", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-124", name: "Cool Cube", rarity: "special", finish: "none", category: "Frozen", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-125", name: "Pa' Pizza", rarity: "special", finish: "none", category: "Frozen", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-126", name: "Snow Crush", rarity: "special", finish: "none", category: "Frozen", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-127", name: "Fishtix", rarity: "special", finish: "none", category: "Frozen", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-128", name: "Freezy Peazy", rarity: "special", finish: "none", category: "Frozen", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-129", name: "Ice Cream Dream", rarity: "special", finish: "none", category: "Frozen", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-130", name: "Popsi Cool", rarity: "special", finish: "none", category: "Frozen", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-131", name: "Yo-Chi", rarity: "special", finish: "none", category: "Frozen", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-132", name: "Cool Cube", rarity: "special", finish: "none", category: "Frozen", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-133", name: "Pa' Pizza", rarity: "special", finish: "none", category: "Frozen", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-134", name: "Snow Crush", rarity: "special", finish: "none", category: "Frozen", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-135", name: "Fishtix", rarity: "special", finish: "none", category: "Frozen", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-136", name: "Freezy Peazy", rarity: "special", finish: "none", category: "Frozen", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-137", name: "Cupcake Queen", rarity: "limited", finish: "none", category: "Limited Edition", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-138", name: "Buttercup", rarity: "limited", finish: "none", category: "Limited Edition", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-139", name: "Tin'a' Tuna", rarity: "limited", finish: "none", category: "Limited Edition", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-140", name: "Twinky Winks", rarity: "limited", finish: "none", category: "Limited Edition", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-141", name: "Papa Tomato", rarity: "limited", finish: "none", category: "Limited Edition", season: 1, own: false, wishlist: false)
        self.saveShopkin("1-142", name: "Sunny Screen", rarity: "limited", finish: "none", category: "Limited Edition", season: 1, own: false, wishlist: false)
        self.saveShopkin("2-001", name: "Chloe Flower", rarity: "rare", finish: "none", category: "Fruit & Veg", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-002", name: "Sour Lemon", rarity: "ultra_rare", finish: "none", category: "Fruit & Veg", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-003", name: "Juicy Orange", rarity: "common", finish: "none", category: "Fruit & Veg", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-004", name: "Corny Cob", rarity: "rare", finish: "none", category: "Fruit & Veg", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-005", name: "Garlic Rose", rarity: "common", finish: "none", category: "Fruit & Veg", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-006", name: "Boo-Hoo Onion", rarity: "common", finish: "none", category: "Fruit & Veg", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-007", name: "Dippy Avocado", rarity: "common", finish: "none", category: "Fruit & Veg", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-008", name: "Silly Chilli", rarity: "common", finish: "none", category: "Fruit & Veg", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-009", name: "Chloe Flower", rarity: "rare", finish: "none", category: "Fruit & Veg", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-010", name: "Sour Lemon", rarity: "ultra_rare", finish: "none", category: "Fruit & Veg", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-011", name: "Juicy Orange", rarity: "common", finish: "none", category: "Fruit & Veg", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-012", name: "Corny Cob", rarity: "rare", finish: "none", category: "Fruit & Veg", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-013", name: "Garlic Rose", rarity: "common", finish: "none", category: "Fruit & Veg", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-014", name: "Boo-Hoo Onion", rarity: "common", finish: "none", category: "Fruit & Veg", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-015", name: "Dippy Avocado", rarity: "common", finish: "none", category: "Fruit & Veg", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-016", name: "Silly Chilli", rarity: "common", finish: "none", category: "Fruit & Veg", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-017", name: "Toasty Pop", rarity: "common", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-018", name: "Brenda Blender", rarity: "rare", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-019", name: "Coffee Drip", rarity: "common", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-020", name: "Saucy Pan", rarity: "rare", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-021", name: "Ma Kettle", rarity: "common", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-022", name: "Zappy Microwave", rarity: "ultra_rare", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-023", name: "Lisa Litter", rarity: "common", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-024", name: "Lana Lamp", rarity: "ultra_rare", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-025", name: "Sizzles", rarity: "rare", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-026", name: "Toasty Pop", rarity: "common", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-027", name: "Brenda Blender", rarity: "rare", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-028", name: "Coffee Drip", rarity: "common", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-029", name: "Saucy Pan", rarity: "rare", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-030", name: "Ma Kettle", rarity: "common", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-031", name: "Zappy Microwave", rarity: "ultra_rare", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-032", name: "Lisa Litter", rarity: "common", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-033", name: "Lana Lamp", rarity: "ultra_rare", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-034", name: "Sizzles", rarity: "rare", finish: "none", category: "Homewares", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-035", name: "Slick Breadstick", rarity: "common", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-036", name: "Mary Muffin", rarity: "ultra_rare", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-037", name: "Carrie Carrot Cake", rarity: "rare", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-038", name: "Mary Meringue", rarity: "ultra_rare", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-039", name: "Pecanna Pie", rarity: "rare", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-040", name: "Choco Lava", rarity: "common", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-041", name: "Fifi Fruit Tart", rarity: "rare", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-042", name: "Danni Danish", rarity: "common", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-043", name: "Cupcake Chic", rarity: "rare", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-044", name: "Slick Breadstick", rarity: "common", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-045", name: "Mary Muffin", rarity: "ultra_rare", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-046", name: "Carrie Carrot Cake", rarity: "rare", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-047", name: "Mary Meringue", rarity: "ultra_rare", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-048", name: "Pecanna Pie", rarity: "rare", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-049", name: "Choco Lava", rarity: "common", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-050", name: "Fifi Fruit Tart", rarity: "rare", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-051", name: "Danni Danish", rarity: "common", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-052", name: "Cupcake Chic", rarity: "rare", finish: "none", category: "Bakery", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-053", name: "Poppy Corn", rarity: "common", finish: "none", category: "Sweet Treats", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-054", name: "Minnie Mintie", rarity: "ultra_rare", finish: "none", category: "Sweet Treats", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-055", name: "Banana Splitty", rarity: "common", finish: "none", category: "Sweet Treats", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-056", name: "Yummy Gum", rarity: "common", finish: "none", category: "Sweet Treats", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-057", name: "Waffle Sue", rarity: "rare", finish: "none", category: "Sweet Treats", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-058", name: "Ice-cream Dream", rarity: "common", finish: "none", category: "Sweet Treats", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-059", name: "Cheery Churro", rarity: "rare", finish: "none", category: "Sweet Treats", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-060", name: "Pamela Pancake", rarity: "ultra_rare", finish: "none", category: "Sweet Treats", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-061", name: "Poppy Corn", rarity: "common", finish: "none", category: "Sweet Treats", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-062", name: "Minnie Mintie", rarity: "ultra_rare", finish: "none", category: "Sweet Treats", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-063", name: "Banana Splitty", rarity: "common", finish: "none", category: "Sweet Treats", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-064", name: "Yummy Gum", rarity: "common", finish: "none", category: "Sweet Treats", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-065", name: "Waffle Sue", rarity: "rare", finish: "none", category: "Sweet Treats", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-066", name: "Ice-cream Dream", rarity: "common", finish: "none", category: "Sweet Treats", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-067", name: "Cheery Churro", rarity: "rare", finish: "none", category: "Sweet Treats", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-068", name: "Pamela Pancake", rarity: "ultra_rare", finish: "none", category: "Sweet Treats", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-069", name: "Fi Fi Flour", rarity: "rare", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-070", name: "Bart Beans", rarity: "common", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-071", name: "Fasta Pasta", rarity: "common", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-072", name: "Olivia Oil", rarity: "ultra_rare", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-073", name: "Honeeey", rarity: "ultra_rare", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-074", name: "Al Foil", rarity: "common", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-075", name: "Toffy Coffee", rarity: "rare", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-076", name: "Cornell Mustard", rarity: "common", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-077", name: "Chris P Crackers", rarity: "rare", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-078", name: "Fi Fi Flour", rarity: "rare", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-079", name: "Bart Beans", rarity: "common", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-080", name: "Fasta Pasta", rarity: "common", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-081", name: "Olivia Oil", rarity: "ultra_rare", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-082", name: "Honeeey", rarity: "ultra_rare", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-083", name: "Al Foil", rarity: "common", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-084", name: "Toffy Coffee", rarity: "rare", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-085", name: "Cornell Mustard", rarity: "common", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-086", name: "Chris P Crackers", rarity: "rare", finish: "none", category: "Pantry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-087", name: "Dishy Liquid", rarity: "common", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-088", name: "Squeaky Clean", rarity: "common", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-089", name: "Wendy Washer", rarity: "rare", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-090", name: "Bree Freshner", rarity: "common", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-091", name: "Molly Mops", rarity: "rare", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-092", name: "Sweeps", rarity: "ultra_rare", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-093", name: "Sarah Softner", rarity: "common", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-094", name: "Peta Plunger", rarity: "ultra_rare", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-095", name: "Leafy", rarity: "common", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-096", name: "Dishy Liquid", rarity: "common", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-097", name: "Squeaky Clean", rarity: "common", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-098", name: "Wendy Washer", rarity: "rare", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-099", name: "Bree Freshner", rarity: "common", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-100", name: "Molly Mops", rarity: "rare", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-101", name: "Sweeps", rarity: "ultra_rare", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-102", name: "Sarah Softner", rarity: "common", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-103", name: "Peta Plunger", rarity: "ultra_rare", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-104", name: "Leafy", rarity: "common", finish: "none", category: "Cleaning & Laundry", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-105", name: "Prommy", rarity: "common", finish: "none", category: "Shoes", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-106", name: "Sneaky Sue", rarity: "rare", finish: "none", category: "Shoes", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-107", name: "Heels", rarity: "common", finish: "none", category: "Shoes", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-108", name: "Sneaky Wedge", rarity: "common", finish: "none", category: "Shoes", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-109", name: "Betty Boot", rarity: "rare", finish: "none", category: "Shoes", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-110", name: "Wedgy Wendy", rarity: "common", finish: "none", category: "Shoes", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-111", name: "Bun Bun Slipper", rarity: "common", finish: "none", category: "Shoes", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-112", name: "Cute Boot", rarity: "ultra_rare", finish: "none", category: "Shoes", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-113", name: "Prommy", rarity: "common", finish: "none", category: "Shoes", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-114", name: "Sneaky Sue", rarity: "rare", finish: "none", category: "Shoes", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-115", name: "Heels", rarity: "common", finish: "none", category: "Shoes", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-116", name: "Sneaky Wedge", rarity: "common", finish: "none", category: "Shoes", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-117", name: "Betty Boot", rarity: "rare", finish: "none", category: "Shoes", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-118", name: "Wedgy Wendy", rarity: "common", finish: "none", category: "Shoes", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-119", name: "Bun Bun Slipper", rarity: "common", finish: "none", category: "Shoes", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-120", name: "Cute Boot", rarity: "ultra_rare", finish: "none", category: "Shoes", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-121", name: "Dribbles", rarity: "special", finish: "none", category: "Baby", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-122", name: "Ga Ga Gourmet", rarity: "special", finish: "none", category: "Baby", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-123", name: "Dum Mee Mee", rarity: "special", finish: "none", category: "Baby", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-124", name: "Baby Swipes", rarity: "special", finish: "none", category: "Baby", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-125", name: "Sippy Sips", rarity: "special", finish: "none", category: "Baby", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-126", name: "Baby Puff", rarity: "special", finish: "none", category: "Baby", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-127", name: "Nappy Dee", rarity: "special", finish: "none", category: "Baby", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-128", name: "Shampoo Sue", rarity: "special", finish: "none", category: "Baby", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-129", name: "Dribbles", rarity: "special", finish: "none", category: "Baby", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-130", name: "Ga Ga Gourmet", rarity: "special", finish: "none", category: "Baby", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-131", name: "Dum Mee Mee", rarity: "special", finish: "none", category: "Baby", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-132", name: "Baby Swipes", rarity: "special", finish: "none", category: "Baby", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-133", name: "Sippy Sips", rarity: "special", finish: "none", category: "Baby", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-134", name: "Baby Puff", rarity: "special", finish: "none", category: "Baby", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-135", name: "Nappy Dee", rarity: "special", finish: "none", category: "Baby", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-136", name: "Shampoo Sue", rarity: "special", finish: "none", category: "Baby", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-137", name: "Marsha Mellow", rarity: "limited", finish: "none", category: "Limited Edition", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-138", name: "Rub-a-Glove", rarity: "limited", finish: "none", category: "Limited Edition", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-139", name: "Lenny Lime", rarity: "limited", finish: "none", category: "Limited Edition", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-140", name: "Lee Tea", rarity: "limited", finish: "none", category: "Limited Edition", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-141", name: "Donna Donut", rarity: "limited", finish: "none", category: "Limited Edition", season: 2, own: false, wishlist: false)
        self.saveShopkin("2-142", name: "Angie Ankle Boot", rarity: "limited", finish: "none", category: "Limited Edition", season: 2, own: false, wishlist: false)
    }
    
    func deleteAll() {
        
        let request = NSFetchRequest(entityName: "Shopkin")
        let fetchRequest: NSFetchRequest = NSFetchRequest(entityName: "Shopkin")
        let fetchedResults = context!.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]?
        
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
        let fetchedResults = context!.executeFetchRequest(fetchRequest, error: &error) as! [NSManagedObject]?
        
        if let results = fetchedResults {
            shopkins = results
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }
}

