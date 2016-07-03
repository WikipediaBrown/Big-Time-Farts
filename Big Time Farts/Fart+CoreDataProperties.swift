//
//  Fart+CoreDataProperties.swift
//  Big Time Farts
//
//  Created by Perris Davis on 7/3/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Fart {

    @NSManaged var date: NSDate?
    @NSManaged var fartSound: String?
    @NSManaged var sectionName: String?
    @NSManaged var subtitle: String?
    @NSManaged var title: String?

}
