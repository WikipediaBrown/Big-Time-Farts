//
//  FartData.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/25/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import UIKit
import CoreData

let delegate = UIApplication.sharedApplication().delegate as! AppDelegate

let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height


func makeButtonTitle(title: String) -> NSAttributedString {
    
    
    let titleAttributes = [
        NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline),
        NSForegroundColorAttributeName: backColor
    ]
    
    let titleString = NSMutableAttributedString(string: "\(title)", attributes: titleAttributes)
    
    
    return titleString
}

func makeMenuButton(title: String) -> NSAttributedString {
    
    
    let titleAttributes = [
        NSFontAttributeName: UIFont.boldSystemFontOfSize(45),
        NSForegroundColorAttributeName: backColor
    ]
    
    let titleString = NSMutableAttributedString(string: "\(title)", attributes: titleAttributes)
    
    
    return titleString
}

func makeEditMenu(title: String) -> NSAttributedString {
    
    
    let titleAttributes = [
        NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleCaption1),
        NSForegroundColorAttributeName: backColor
    ]
    
    let titleString = NSMutableAttributedString(string: "\(title)", attributes: titleAttributes)
    
    
    return titleString
}



let primaryColor = UIColor(colorLiteralRed: 27.0/255.0, green: 30.0/255.0, blue: 37.0/255.0, alpha: 1.0)

let secondaryColor = UIColor(colorLiteralRed: 230.0/255.0, green: 67.0/255.0, blue: 64.0/255.0, alpha: 1.0)

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

extension MenuViewController {
    func setupFartData() {
        
        
            loadFartData()
            do {
                try delegate.managedObjectContext.save()
            } catch {
                print(error)
            }
        
    }
    
    func loadFartData() {
        
        
            let fetchFartRequest = NSFetchRequest(entityName: "Fart")
            
            do {
                userFartList = try delegate.managedObjectContext.executeFetchRequest(fetchFartRequest) as? [Fart]
            } catch {
                print(error)
            }
        
    }
    
}
