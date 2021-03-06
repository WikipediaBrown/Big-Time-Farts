//
//  DimmingViewController.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/30/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import UIKit
import CoreData

class DimmingViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var editStackView: UIStackView!
    
    var buttonStackView: UIStackView!
    
    var cancelButton: UIButton!
    
    var saveButton: UIButton!
    
    var mainViewHeader: UILabel!
    
    var mainView: UILabel!
    
    var fartNameView: UITextField!
    
    var backgroundView: UIView!
    
    var containerView: UIView!
    
    var viewWidth: CGFloat!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.6, initialSpringVelocity: 0.3, options: .CurveEaseOut, animations: {
            
            self.containerView.center.y = self.view.frame.size.height * 0.3
            self.backgroundView.alpha = 0.6
            
            }, completion: nil)
    }
        
    func setupViews() {
        
        viewWidth = view.frame.size.width
        
        containerView = UIView(frame: CGRect(x: viewWidth * 0.1, y: -view.frame.size.height * 0.5, width: view.frame.size.width * 0.8, height: view.frame.size.height * 0.4))
        containerView.backgroundColor = primaryColor
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = secondaryColor.CGColor
        containerView.layer.cornerRadius = viewWidth/25
        
        
        backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.blackColor()
        backgroundView.alpha = 0.0
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        let outterTap = UITapGestureRecognizer(target: self, action: #selector(dismissFartSave))
        outterTap.delegate = self
        backgroundView.addGestureRecognizer(outterTap)
        self.view.addSubview(backgroundView)
        self.view.addSubview(containerView)

        editStackView = UIStackView()
        editStackView.spacing = 0
        editStackView.translatesAutoresizingMaskIntoConstraints = false
        editStackView.alignment = .Fill
        editStackView.distribution = .FillEqually
        editStackView.axis = .Vertical
        containerView.addSubview(editStackView)
        
        mainViewHeader = UILabel(frame:CGRectMake(0, 0, view.frame.width, view.frame.height))
        mainViewHeader.attributedText = makeButtonTitle("Save Your Big Time Fart")
        mainViewHeader.textAlignment = .Center
        mainViewHeader.backgroundColor = .clearColor()
        editStackView.addArrangedSubview(mainViewHeader)
        
        mainView = UILabel()
        mainView.attributedText = makeEditMenu("Enter the name of your fart below.")
        mainView.textAlignment = .Center
        mainView.backgroundColor = .clearColor()
        editStackView.addArrangedSubview(mainView)
        
        fartNameView = UITextField()
        fartNameView.backgroundColor = .clearColor()
        fartNameView.textColor = backColor
        fartNameView.tintColor = secondaryColor
        fartNameView.attributedPlaceholder = makeButtonTitle("What's your fart's name?")
        fartNameView.becomeFirstResponder()
        editStackView.addArrangedSubview(fartNameView)
        
        let paddingView = UIView(frame:CGRectMake(0, 0, 30, 30))
        fartNameView.leftView = paddingView
        fartNameView.leftViewMode = UITextFieldViewMode.Always
//        fartNameView.placeholder="What's your fart's name?"
        
        buttonStackView = UIStackView()
        buttonStackView.spacing = 5
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.distribution = .FillEqually
        buttonStackView.axis = .Horizontal
        editStackView.addArrangedSubview(buttonStackView)
        
        cancelButton = UIButton()
        cancelButton.setAttributedTitle(makeButtonTitle("Cancel"), forState: .Normal)
        cancelButton.backgroundColor = secondaryColor
        cancelButton.setTitleColor(secondaryColor, forState: .Highlighted)
        cancelButton.addTarget(self, action: #selector(cancelFartButtonTapped), forControlEvents: .TouchUpInside)
        buttonStackView.addArrangedSubview(cancelButton)
        
        saveButton = UIButton()
        saveButton.setAttributedTitle(makeButtonTitle("Save"), forState: .Normal)
        saveButton.backgroundColor = secondaryColor
        saveButton.setTitleColor(UIColor.darkGrayColor(), forState: .Normal)
        saveButton.setTitleColor(UIColor.greenColor(), forState: .Highlighted)
        saveButton.addTarget(self, action: #selector(saveFartButtonTapped), forControlEvents: .TouchUpInside)
        buttonStackView.addArrangedSubview(saveButton)
        
        let viewsDictionary = ["v0": backgroundView, "v1": editStackView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[v1]-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[v1]-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
        
        
        
    }
    
    func dismissFartSave() {
        
        let menu = MenuViewController()
        menu.setupViews()
        fartNameView.resignFirstResponder()
        
        UIView.animateWithDuration(0.18, delay: 0.0, options: .CurveEaseIn, animations: {
            self.backgroundView.alpha = 0.0
            self.containerView.center.y = -self.view.frame.size.height * 0.4
            }) { (true) in
                self.dismissViewControllerAnimated(false) {
                    
                }
        }

    }
    
    func cancelFartButtonTapped() {
        fartNameView.resignFirstResponder()
        dismissFartSave()
    }
    
    func saveFartButtonTapped() {
        
        let fartName = fartNameView.text
        
        fartNameView.resignFirstResponder()
        
        if fartName != "" {
            
            let documentsPath = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String
            let fileManager = NSFileManager.defaultManager()
            let files = try? fileManager.contentsOfDirectoryAtPath(documentsPath)
            let count = files!.count
            print (count)
            
            let context = delegate.managedObjectContext
            
            do {
                let documentDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
                let originPath = documentDirectory.URLByAppendingPathComponent("/fart.m4a")
                let destinationPath = documentDirectory.URLByAppendingPathComponent("/\(fartName)-\(count)-userAdded.m4A")
                try NSFileManager.defaultManager().moveItemAtURL(originPath, toURL: destinationPath)
                
                let newFart = NSEntityDescription.insertNewObjectForEntityForName("Fart", inManagedObjectContext: context) as! Fart
                newFart.sectionName = "fartSelect"
                newFart.title = fartName
                newFart.subtitle = ""
                newFart.fartSound = "/\(fartName)-\(count)-userAdded.m4A"
                newFart.date = NSDate()
                
                userFartList?.append(newFart)
                try context.save()

            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            dismissFartSave()
            NSNotificationCenter.defaultCenter().postNotificationName("load", object: nil)
            
        } else {
            
        }
        
    }
}
