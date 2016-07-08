//
//  FartData.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/25/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import UIKit
import CoreData

var fartSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("test-fart", ofType: "mp3")!).absoluteString

struct FartData {
    
    var sectionName: String
    var title: String
    var subtitle: String
    let fartSound: String
    var date: NSDate
}

let firstFart = FartData(sectionName: "fartSelect", title: "first-fart", subtitle: "System Fart", fartSound: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("test-fart", ofType: "mp3")!).absoluteString, date: NSDate())
let secondFart = FartData(sectionName: "fartSelect", title: "second-fart", subtitle: "System Fart", fartSound: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("test-2", ofType: "mp3")!).absoluteString, date: NSDate())

let systemFartList = [firstFart,secondFart]
var fartList: [Fart]?
var userFartList: [Fart]?

let delegate = UIApplication.sharedApplication().delegate as? AppDelegate


extension MenuViewController {
    func setupFartData() {
        
            if let context = delegate?.managedObjectContext {
            
//            let firstFart = NSEntityDescription.insertNewObjectForEntityForName("Fart", inManagedObjectContext: context) as! Fart
//            firstFart.sectionName = "fartSelect"
//            firstFart.title = "first-fart"
//            firstFart.subtitle = "System Fart"
//            firstFart.fartSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("test-fart", ofType: "mp3")!).absoluteString
//            firstFart.date = NSDate()
//            
//            let secondFart = NSEntityDescription.insertNewObjectForEntityForName("Fart", inManagedObjectContext: context) as! Fart
//            secondFart.sectionName = "fartSelect"
//            secondFart.title = "second-fart"
//            secondFart.subtitle = "System Fart"
//            secondFart.fartSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("test-2", ofType: "mp3")!).absoluteString
//            secondFart.date = NSDate()
//            
//            let systemFartList = [firstFart, secondFart]
            loadFartData()
            //fartList = systemFartList + userFartList!
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
        
    }
    
    func loadFartData() {
        
        if let context = delegate?.managedObjectContext {
        
            let fetchFartRequest = NSFetchRequest(entityName: "Fart")
            
            do {
                userFartList = try context.executeFetchRequest(fetchFartRequest) as? [Fart]
            } catch {
                print(error)
            }
        }
    
    }
    
}
