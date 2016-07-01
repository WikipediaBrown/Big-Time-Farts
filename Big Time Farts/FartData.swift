//
//  FartData.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/25/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import Foundation

struct FartData {
    
    var sectionName: String
    var title: String
    var subtitle: String
    let fartSound: NSURL
    var date: NSDate
}

var fartSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("test-fart", ofType: "mp3")!)



var fartList = [
        
    FartData(sectionName: "fartSelect", title: "first-fart", subtitle: "System Fart", fartSound: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("test-fart", ofType: "mp3")!), date: NSDate()),
    FartData(sectionName: "fartSelect", title: "second-fart", subtitle: "System Fart", fartSound: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("test-2", ofType: "mp3")!), date: NSDate())
]