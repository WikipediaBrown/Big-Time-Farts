//
//  MenuViewController.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/24/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.purpleColor()
        
        fartTable.estimatedRowHeight = 50
        fartTable.rowHeight = UITableViewAutomaticDimension
        
        fartTable.setNeedsLayout()
        fartTable.layoutIfNeeded()
        
        setupViews()
    }
    
    let fartTable: UITableView = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 1
        } else {
            
            return fartList.count
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let topCell = tableView.dequeueReusableCellWithIdentifier("BigTomFartsCell", forIndexPath: indexPath) as! BigTomFartsTableViewCell
            
            return topCell
        } else {
            
            let fartCell = tableView.dequeueReusableCellWithIdentifier("FartCell", forIndexPath: indexPath) as! FartTableViewCell
            
            fartCell.textLabel?.text = fartList[indexPath.row].name
            return fartCell
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            
            return nil
            
            
        } else {
            
            let headerCell = tableView.dequeueReusableHeaderFooterViewWithIdentifier("MenuHeader")
            return headerCell
            
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        fartSound = fartList[indexPath.row].fartSound
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            
            return 0
        } else {
            
            return 50
        }
    }
    
    func setupViews() {
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 64))
        self.view.addSubview(navBar)
        let navBarItem = UINavigationItem()
        navBar.items = [navBarItem]
        
        navBarItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Cancel, target: self, action: #selector(self.dismissMenu))
        
        self.view.addSubview(fartTable)
        fartTable.delegate = self
        fartTable.dataSource = self
        fartTable.registerClass(FartTableViewCell.self, forCellReuseIdentifier: "FartCell")
        fartTable.registerClass(BigTomFartsTableViewCell.self, forCellReuseIdentifier: "BigTomFartsCell")
        fartTable.registerClass(MenuHeaderSection.self, forHeaderFooterViewReuseIdentifier: "MenuHeader")
        
        fartTable.separatorStyle = .None
        
        let viewsDictionary = ["v0": fartTable]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-64-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func dismissMenu() {
        self.dismissViewControllerAnimated(true) {
            
        }
        
    }
    
}
