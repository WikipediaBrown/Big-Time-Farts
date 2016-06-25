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
        return fartList.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
        
            let cell:UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "BigTomFartsCell")
            return cell
        }
            
        else {
        
            let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "FartCell")
            cell.textLabel?.text = fartList[indexPath.row].name
            return cell
        }
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerCell = tableView.dequeueReusableHeaderFooterViewWithIdentifier("MenuHeader")
        return headerCell
    }
    
    func setupViews() {
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 64))
        self.view.addSubview(navBar)
        self.view.addSubview(fartTable)
        fartTable.delegate = self
        fartTable.dataSource = self
        fartTable.registerClass(FartTableViewCell.self, forCellReuseIdentifier: "FartCell")
        fartTable.registerClass(BigTomFartsTableViewCell.self, forCellReuseIdentifier: "BigTomFartsCell")
        fartTable.registerClass(MenuHeaderSection.self, forHeaderFooterViewReuseIdentifier: "MenuHeader")
    
        let viewsDictionary = ["v0": fartTable]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-64-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }

}
