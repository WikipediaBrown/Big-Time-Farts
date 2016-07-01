//
//  DimmingViewController.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/30/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import UIKit

class DimmingViewController: UIViewController, UIGestureRecognizerDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.clearColor()
        // Do any additional setup after loading the view.
        setupViews()
    }
    
    var mainView: UIView!
    
    var backgroundView: UIView!
    
    func setupViews() {
        
        backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.blackColor()
        backgroundView.alpha = 0.2
        backgroundView.translatesAutoresizingMaskIntoConstraints = false
        let outterTap = UITapGestureRecognizer(target: self, action: #selector(dismissThis))
        outterTap.delegate = self
        backgroundView.addGestureRecognizer(outterTap)
        self.view.addSubview(backgroundView)
        
        mainView = UIView()
        mainView.backgroundColor = UIColor.redColor()
        mainView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(mainView)
        
        let viewsDictionary = ["v0": backgroundView, "v1": mainView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
        
        
    }
    
    func dismissThis() {
        self.dismissViewControllerAnimated(true) {
            
        }
    
    }

}
