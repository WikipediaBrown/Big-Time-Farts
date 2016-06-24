//
//  ViewController.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/23/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import UIKit
import AVFoundation

class FartButtonViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.redColor()
        setupButton()
    }

    let fartButton: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = UIColor.brownColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    func setupButton() {
    
        self.view.addSubview(fartButton)
    
        fartButton.addTarget(self, action: #selector(FartButtonViewController.playFart), forControlEvents: .TouchUpInside)

        let viewsDictionary = ["fartButton": fartButton]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[fartButton]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[fartButton]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func playFart() {
    
        print("poop")
    }
    
    
}

