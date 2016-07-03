//
//  MenuHeaderSection.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/25/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import UIKit

class MenuHeaderSection: UITableViewHeaderFooterView {
    
    

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let collectionHeader: UILabel = {
        var noteCount = UILabel()
        noteCount.text = "Select a fart from the Fart Locker"
        noteCount.textAlignment = .Center
        noteCount.font = UIFont.boldSystemFontOfSize(14)
        noteCount.textColor = UIColor.blueColor()
        noteCount.translatesAutoresizingMaskIntoConstraints = false
        return noteCount
        
    }()
    
    
    func setupViews() {
        
        addSubview(collectionHeader)
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionHeader]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionHeader]))
    }

}
