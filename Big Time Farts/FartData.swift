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
    var name: String
    let fartSound: NSURL
}


var fartList = [FartData(sectionName: "fartSelect", name: "first-fart", fartSound: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("test-fart", ofType: "mp3")!)), FartData(sectionName: "fartSelect", name: "first-fart", fartSound: NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("test-fart", ofType: "mp3")!))]
