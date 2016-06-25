//
//  MenuHeaderSection.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/25/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import UIKit

var noteCount = UILabel()

class MenuHeaderSection: UITableViewHeaderFooterView {

    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    let collectionHeader: UILabel = {
        let label = UILabel()
        noteCount.text = "You've got  notes saved"
        noteCount.font = UIFont.boldSystemFontOfSize(14)
        noteCount.textColor = UIColor.yellowColor()
        noteCount.translatesAutoresizingMaskIntoConstraints = false
        return noteCount
        
    }()
    
    
    func setupViews() {
        
        addSubview(collectionHeader)
        contentView.backgroundColor = UIColor.greenColor()
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-16-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionHeader]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionHeader]))
    }

}
