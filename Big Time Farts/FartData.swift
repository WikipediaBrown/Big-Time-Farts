//
//  FartData.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/25/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import UIKit
import CoreData





func makeButtonTitle(title: String) -> NSAttributedString {
    
    
    let titleAttributes = [
        NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline),
        NSForegroundColorAttributeName: primaryColor
    ]
    
    let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
    
    
    return titleString
}



let primaryColor = UIColor(colorLiteralRed: 38.0/255.0, green: 37.0/255.0, blue: 64.0/255.0, alpha: 1.0)

let secondaryColor = UIColor(colorLiteralRed: 242/255.0, green: 99/255.0, blue: 95/255.0, alpha: 1.0)

let backColor = UIColor(colorLiteralRed: 245.0/255.0, green: 245.0/255.0, blue: 245.0/255.0, alpha: 1.8)







let initialFart = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("test-fart", ofType: "mp3")!).absoluteString

var defaults = NSUserDefaults.standardUserDefaults()

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
var userFartList: [Fart]?

let delegate = UIApplication.sharedApplication().delegate as? AppDelegate


extension MenuViewController {
    func setupFartData() {
        
        if let context = delegate?.managedObjectContext {
            
            loadFartData()
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
