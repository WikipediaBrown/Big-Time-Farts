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
        self.view.backgroundColor = UIColor.purpleColor()
        
        setupViews()
        
    }
    
    let fartTable: UITableView = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return .count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell:UITableViewCell = fartTable.dequeueReusableCellWithIdentifier("fartCell") as! FartTableViewCell
        
        cell.textLabel?.text = fartData[indexPath.row]
        
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return menuSection.count
    }
    
    func setupViews() {
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 64))
        self.view.addSubview(navBar)
        self.view.addSubview(fartTable)
        fartTable.delegate = self
        fartTable.dataSource = self
        fartTable.registerClass(FartTableViewCell.self, forCellReuseIdentifier: "fartCell")
    
        let viewsDictionary = ["v0": fartTable]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-64-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }

}
