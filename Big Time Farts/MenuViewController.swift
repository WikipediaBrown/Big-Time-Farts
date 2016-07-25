//
//  MenuViewController.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/24/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import UIKit
import CoreData

let fetchedFartResultsController: NSFetchedResultsController = {
    
    let fetchRequest = NSFetchRequest(entityName: "Fart")
    fetchRequest.sortDescriptors = [NSSortDescriptor(key: "date", ascending: true)]
    let context = delegate.managedObjectContext
    let frc = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
    
    return frc
}()

class MenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate {
    
    var selectedFart: NSIndexPath!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchedFartResultsController.delegate = self
        
        do {
        
            try fetchedFartResultsController.performFetch()
            print(fetchedFartResultsController.sections?[0].numberOfObjects)
        } catch {
        
            print("you're wrong")

        }
        
        view.backgroundColor = backColor
        
        //fartTable.estimatedRowHeight = 50
        //fartTable.rowHeight = UITableViewAutomaticDimension
        
        fartTable.setNeedsLayout()
        fartTable.layoutIfNeeded()
        
        setupFartData()
        
        setupViews()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.reloadFarts),name:"load", object: nil)
        
        
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        if type == .Insert {
            
            let fartIndexPath = NSIndexPath(forRow: newIndexPath!.row, inSection: 2)
        
            fartTable.insertRowsAtIndexPaths([fartIndexPath], withRowAnimation: .Right)
            fartTable.scrollToRowAtIndexPath(fartIndexPath, atScrollPosition: .Top, animated: true)
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {}
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let swipeShare = UITableViewRowAction(style: .Normal, title: "Share") { (action: UITableViewRowAction, indexPath: NSIndexPath) in
            
//            let noteToShare = notes![indexPath.row].note
//            let activityViewController = UIActivityViewController(activityItems: [noteToShare], applicationActivities: nil)
//            self.presentViewController(activityViewController, animated: true, completion: nil)
            
            print(userFartList![indexPath.row].fartSound)
        }
        let swipeDelete = UITableViewRowAction(style: .Default, title: "Delete") { (action: UITableViewRowAction, indexPath: NSIndexPath) in
            
            let fartToDelete = userFartList![indexPath.row]
            userFartList?.removeAtIndex(indexPath.row)
            let context = delegate.managedObjectContext
            context.deleteObject(fartToDelete)
            
            do{
                try delegate.managedObjectContext.save()
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            }
            catch let error{
                print("Could not save Deletion \(error)")
            }
            
        }
        
        let section = indexPath.section
        
        switch section {
        case 0:
            return [swipeShare]

        case 1:
            return [swipeShare]

        case 2:
            return [swipeDelete, swipeShare]
        default:
            return [swipeDelete, swipeShare]
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
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
        
        
//        let today = NSDate()
//        let calendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)
//        let todayAtMidnight = calendar?.startOfDayForDate(today)
//        print(todayAtMidnight)
        
        
        
        var underText = subtitle
        
        
        if subtitle == "" {
            
            underText = "\(dateFormatter.stringFromDate(date)) at \(timeFormatter.stringFromDate(date))"
        }
        
        
        let titleAttributes = [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleHeadline),
            NSForegroundColorAttributeName: primaryColor
        ]
        
        let subtitleAttributes = [
            NSFontAttributeName: UIFont.preferredFontForTextStyle(UIFontTextStyleFootnote),
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
            
            if let count = fetchedFartResultsController.sections?[0].numberOfObjects {
                return count
            }

            return 0
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
            
            let fartIndexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
            
            let cellFart = fetchedFartResultsController.objectAtIndexPath(fartIndexPath) as! Fart
            
            let fartCell = tableView.dequeueReusableCellWithIdentifier("FartCell", forIndexPath: indexPath) as! FartTableViewCell
            fartCell.selectionStyle = UITableViewCellSelectionStyle.None
            
            if defaults.objectForKey("defaultFart") as? String == cellFart.fartSound {
                
                fartCell.fartSelectedImage.hidden = false
                selectedFart = indexPath
            }
            
            fartCell.fartDescriptionn.attributedText = makeFartLabel(title: cellFart.title!, subtitle: cellFart.subtitle!, date: cellFart.date!)
            
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
    
    func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        if indexPath.section == 0 {
        
            return nil
        } else {
        
            return indexPath
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let fartIndexPath = NSIndexPath(forRow: indexPath.row, inSection: 0)
        
        let cellFart = fetchedFartResultsController.objectAtIndexPath(fartIndexPath) as! Fart
        
        switch indexPath.section {
            
        case 0: break
            
        case 1: defaults.setObject(systemFartList[indexPath.row].fartSound, forKey: "defaultFart")
        
        if selectedFart != nil {
            
            let oldFartCell = tableView.cellForRowAtIndexPath(selectedFart) as! FartTableViewCell
            oldFartCell.fartSelectedImage.hidden = true
            
        }
        
        let fartCell = tableView.cellForRowAtIndexPath(indexPath) as! FartTableViewCell
        fartCell.fartSelectedImage.hidden = false
            
        case 2: defaults.setObject(cellFart.fartSound!, forKey: "defaultFart")
        
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
        
        if indexPath.section != 0 {
            
            let fartCell = tableView.cellForRowAtIndexPath(indexPath) as! FartTableViewCell
            
            switch indexPath.section {
                
            case 0: break
                
            case 1: fartCell.fartSelectedImage.hidden = true
                
                
            case 2: fartCell.fartSelectedImage.hidden = true
                
                
            default: break
            }
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
        navBar.titleTextAttributes = [NSForegroundColorAttributeName: backColor]
        navBar.tintColor = secondaryColor
        self.view.addSubview(navBar)
        let navBarItem = UINavigationItem()
        navBarItem.title = "Menu"
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
    }
    
    func dismissMenu() {
        self.dismissViewControllerAnimated(true) {
            
        }
        
    }
    
    func dimView() {
        
        let dimmer = DimmingViewController()
        dimmer.modalPresentationStyle = .Custom
        dimmer.modalTransitionStyle = .CrossDissolve
        presentViewController(dimmer, animated: false, completion: nil)
        
    }
    
    func reloadFarts() {
        
        UIView.animateWithDuration(0.35) { [unowned self] in
            
            playSaveStackView.hidden = true
            playSaveStackView.alpha = 0
        }
        
    }
    
}
