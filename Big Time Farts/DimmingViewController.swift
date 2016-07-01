//
//  DimmingViewController.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/30/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import UIKit

class DimmingViewController: UIViewController, UIGestureRecognizerDelegate {
    
    var editStackView: UIStackView!
    
    var buttonStackView: UIStackView!
    
    var cancelButton: UIButton!
    
    var saveButton: UIButton!
    
    var mainViewHeader: UILabel!
    
    var mainView: UILabel!
    
    var fartNameView: UITextField!
    
    var backgroundView: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    override func viewWillAppear(animated: Bool) {
        UIView.animateWithDuration(1.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .CurveEaseIn, animations: {
            self.editStackView.frame = CGRect(x: (self.view.frame.width/2) - 125, y: (self.view.frame.height/2) - 200, width: 250, height: 300)
            }, completion: nil)
    }
    
    func setupViews() {
        
        backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.blackColor()
        backgroundView.alpha = 0.2
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        let outterTap = UITapGestureRecognizer(target: self, action: #selector(dismissFartSave))
        outterTap.delegate = self
        backgroundView.addGestureRecognizer(outterTap)
        self.view.addSubview(backgroundView)
        
        editStackView = UIStackView()
        editStackView.spacing = 0
        editStackView.translatesAutoresizingMaskIntoConstraints = false
        editStackView.distribution = .FillEqually
        editStackView.axis = .Vertical
        self.view.addSubview(editStackView)
        
        mainViewHeader = UILabel()
        mainViewHeader.text = "Save Your Big Time Fart"
        mainViewHeader.backgroundColor = UIColor.darkGrayColor()
        editStackView.addArrangedSubview(mainViewHeader)
        
        //mainView = UIView(frame: CGRect(x: (view.frame.width/2) - 125, y: -300, width: 250, height: 300))
        mainView = UILabel()
        mainView.text = "Enter the name of your fart below."
        mainView.backgroundColor = UIColor.redColor()
        editStackView.addArrangedSubview(mainView)
        
        fartNameView = UITextField()
        fartNameView.backgroundColor = UIColor.yellowColor()
        editStackView.addArrangedSubview(fartNameView)
        
        let paddingView = UIView(frame:CGRectMake(0, 0, 30, 30))
        fartNameView.leftView = paddingView
        fartNameView.leftViewMode = UITextFieldViewMode.Always
        fartNameView.placeholder="What's your fart's name?"
        
        buttonStackView = UIStackView()
        buttonStackView.spacing = 0
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.distribution = .FillEqually
        buttonStackView.axis = .Horizontal
        editStackView.addArrangedSubview(buttonStackView)
        
        cancelButton = UIButton()
        cancelButton.setTitle("Cancel", forState: .Normal)
        cancelButton.backgroundColor = UIColor.cyanColor()
        cancelButton.addTarget(self, action: #selector(cancelFartButtonTapped), forControlEvents: .TouchUpInside)
        buttonStackView.addArrangedSubview(cancelButton)
        
        saveButton = UIButton()
        saveButton.setTitle("Save", forState: .Normal)
        saveButton.backgroundColor = UIColor.orangeColor()
        saveButton.addTarget(self, action: #selector(saveFartButtonTapped), forControlEvents: .TouchUpInside)
        buttonStackView.addArrangedSubview(saveButton)
        
        let viewsDictionary = ["v0": backgroundView, "v1": editStackView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[v1]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-100-[v1]-300-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))

        
        
        
    }
    
    func dismissFartSave() {
        
        UIView.animateWithDuration(3.0, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.3, options: .CurveEaseIn, animations: {
            self.editStackView.frame = CGRect(x: (self.view.frame.width/2) - 125, y: -300, width: 250, height: 300)
            }, completion: nil)
        
        self.dismissViewControllerAnimated(true) {
            
        }
    
    }
    
    func cancelFartButtonTapped() {
        fartNameView.resignFirstResponder()
        dismissFartSave()
    }
    
    func saveFartButtonTapped() {
        
        print("poop")
    }

}
