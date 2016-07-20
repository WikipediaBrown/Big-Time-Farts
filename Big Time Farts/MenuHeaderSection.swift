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
    
    let containerView: UIView = {
    
        let view = UIView()
        view.layer.borderWidth = 2
        view.layer.borderColor = primaryColor.CGColor
        view.backgroundColor = secondaryColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    let collectionHeader: UILabel = {
        var noteCount = UILabel()
        noteCount.text = "Select a fart from the Fart Locker"
        noteCount.textAlignment = .Center
        noteCount.textColor = secondaryColor
        noteCount.backgroundColor = primaryColor
        noteCount.translatesAutoresizingMaskIntoConstraints = false
        return noteCount
        
    }()
    
    
    func setupViews() {
        
        addSubview(containerView)
        containerView.addSubview(collectionHeader)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-3-[v0]-3-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionHeader]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-3-[v0]-3-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": collectionHeader]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": containerView]))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": containerView]))
    }

}
