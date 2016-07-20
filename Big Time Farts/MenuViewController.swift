//
//  MenuViewController.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/24/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var selectedFart: NSIndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = backColor
        
        //fartTable.estimatedRowHeight = 50
        //fartTable.rowHeight = UITableViewAutomaticDimension
        
        fartTable.setNeedsLayout()
        fartTable.layoutIfNeeded()
        setupFartData()
        
        setupViews()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.reloadFarts),name:"load", object: nil)
        
        
        
    }
    
    let fartTable: UITableView = {
        
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    func makeFartLabel(title title: String, subtitle: String, date: NSDate) -> NSAttributedString {
        
        let dateFormatter = NSDateFormatter()
        let timeFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "EEEE, MMMM d"
        timeFormatter.dateFormat = "h:m:ss a"
        
        
        let today = NSDate()
        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
        let todayAtMidnight = calendar?.startOfDayForDate(today)
        print(todayAtMidnight)
        
        
        
        var underText = subtitle
        
        
        if subtitle == "" {
            
            underText = "\(dateFormatter.stringFromDate(date)) at \(timeFormatter.stringFromDate(date))"
        }
        
        
        let titleAttributes = [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline),
            NSForegroundColorAttributeName: primaryColor
        ]
        
        let subtitleAttributes = [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleSubheadline),
            NSForegroundColorAttributeName: secondaryColor
        ]
        
        let titleString = NSMutableAttributedString(string: "\(title)\n", attributes: titleAttributes)
        let subtitleString = NSAttributedString(string: underText, attributes: subtitleAttributes)
        
        titleString.appendAttributedString(subtitleString)
        
        return titleString
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            return 1
        } else if section == 1 {
            
            return systemFartList.count
        } else{
            
            return userFartList!.count
        }
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            let topCell = tableView.dequeueReusableCellWithIdentifier("BigTomFartsCell", forIndexPath: indexPath) as! BigTomFartsTableViewCell
            topCell.selectionStyle = UITableViewCellSelectionStyle.None
            topCell.saveRecordedFartButton.addTarget(self, action: #selector(self.dimView), forControlEvents: .TouchUpInside)
            return topCell
        } else if indexPath.section == 1 {
            
            let fartCell = tableView.dequeueReusableCellWithIdentifier("FartCell", forIndexPath: indexPath) as! FartTableViewCell
            fartCell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if defaults.objectForKey("defaultFart") as? String == systemFartList[indexPath.row].fartSound {
                
                fartCell.fartSelectedImage.hidden = false
                selectedFart = indexPath
            }
            
            fartCell.fartDescriptionn.attributedText = makeFartLabel(title: systemFartList[indexPath.row].title, subtitle: systemFartList[indexPath.row].subtitle, date: systemFartList[indexPath.row].date)
            
            fartCell.cellIndexPath = indexPath.row
            
            fartCell.cellSection = indexPath.section
            
            fartCell.fartDescriptionn.numberOfLines = 0
            return fartCell
            
            
        } else {
            
            let fartCell = tableView.dequeueReusableCellWithIdentifier("FartCell", forIndexPath: indexPath) as! FartTableViewCell
            fartCell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if defaults.objectForKey("defaultFart") as? String == userFartList![indexPath.row].fartSound {
                
                fartCell.fartSelectedImage.hidden = false
                selectedFart = indexPath
            }
            
            fartCell.fartDescriptionn.attributedText = makeFartLabel(title: userFartList![indexPath.row].title!, subtitle: userFartList![indexPath.row].subtitle!, date: userFartList![indexPath.row].date!)
            
            fartCell.cellIndexPath = indexPath.row
            
            fartCell.cellSection = indexPath.section
            
            fartCell.fartDescriptionn.numberOfLines = 0
            return fartCell
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 3
    }
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            
            return nil
        } else if section == 1 {
            
            let headerCell = tableView.dequeueReusableHeaderFooterViewWithIdentifier("MenuHeader")
            return headerCell
        } else {
            
            return nil
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
        switch indexPath.section {
            
        case 0: break
            
        case 1: defaults.setObject(systemFartList[indexPath.row].fartSound, forKey: "defaultFart")
        
        if selectedFart != nil {
        
        let oldFartCell = tableView.cellForRowAtIndexPath(selectedFart) as! FartTableViewCell
        oldFartCell.fartSelectedImage.hidden = true
        
        }
        
        let fartCell = tableView.cellForRowAtIndexPath(indexPath) as! FartTableViewCell
        fartCell.fartSelectedImage.hidden = false
            
        case 2: defaults.setObject(userFartList![indexPath.row].fartSound!, forKey: "defaultFart")
        
        if selectedFart != nil {
            
            let oldFartCell = tableView.cellForRowAtIndexPath(selectedFart) as! FartTableViewCell
            oldFartCell.fartSelectedImage.hidden = true
            
        }
        
        let fartCell = tableView.cellForRowAtIndexPath(indexPath) as! FartTableViewCell
        fartCell.fartSelectedImage.hidden = false
            
        default: break
        }
    }
    
    func tableView(tableView: UITableView, didDeselectRowAtIndexPath indexPath: NSIndexPath) {
        
        let fartCell = tableView.cellForRowAtIndexPath(indexPath) as! FartTableViewCell
        
        switch indexPath.section {
            
        case 0: break
            
        case 1: fartCell.fartSelectedImage.hidden = true
            
            
        case 2: fartCell.fartSelectedImage.hidden = true
            
            
        default: break
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            
            return 0
        } else if section == 1 {
            
            return 50
        } else {
            
            return 0
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func setupViews() {
        
        let navBar: UINavigationBar = UINavigationBar(frame: CGRectMake(0, 0, self.view.frame.size.width, 64))
        navBar.translucent = false
        navBar.barTintColor = primaryColor
        navBar.tintColor = secondaryColor
        self.view.addSubview(navBar)
        let navBarItem = UINavigationItem()
        navBar.items = [navBarItem]
        
        navBarItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Done, target: self, action: #selector(self.dismissMenu))
        
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
        fartTable.reloadData()
    }
    
    func dismissMenu() {
        self.dismissViewControllerAnimated(true) {
            
        }
        
    }
    
    func dimView() {
        
        let dimmer = DimmingViewController()
        dimmer.modalPresentationStyle = .Custom
        dimmer.modalTransitionStyle = .CrossDissolve
        presentViewController(dimmer, animated: true, completion: nil)
        
    }
    
    func reloadFarts() {
        
        fartTable.reloadData()
        UIView.animateWithDuration(0.35) { [unowned self] in
            
            playSaveStackView.hidden = true
            playSaveStackView.alpha = 0
        }
        
    }
    
}
