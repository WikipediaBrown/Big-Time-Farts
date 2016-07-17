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
    
    var chosenFart = defaults.objectForKey("defaultFart")


    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = .whiteColor()
        setupButton()
    }
    
    override func viewDidAppear(animated: Bool) {
        var fleek1 = defaults.objectForKey("defaultFart")
        
        print(fleek1)
    }

    let fartButton: UIButton = {
        
        let button = UIButton()
        button.setImage(UIImage(named: "heart-full"), forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let menuButton: UIButton = {
        
        let button = UIButton()
        button.layer.cornerRadius = 17
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.blackColor().CGColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var fartPlayer: AVAudioPlayer = {
        let player = AVAudioPlayer()
        return player
    
    }()
        
    func setupButton() {
    
        self.view.addSubview(fartButton)
        self.view.addSubview(menuButton)
        fartButton.addTarget(self, action: #selector(FartButtonViewController.playFart), forControlEvents: .TouchUpInside)
        menuButton.addTarget(self, action: #selector(FartButtonViewController.showMenu), forControlEvents: .TouchUpInside)
        
        try? fartRecordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        try? fartRecordingSession.setActive(true)
        try? fartRecordingSession.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)

        let viewsDictionary = ["v0": fartButton, "v1": menuButton]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[v1]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[v0]-20-[v1(100)]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func playFart() {

        do {
            
            self.fartPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: defaults.objectForKey("defaultFart") as! String)!)
            self.fartPlayer.play()
            var fleek1 = defaults.objectForKey("defaultFart")
            
            print(fleek1)        } catch {
        
            print("Error getting the fart file: \(error)")
        }
    }
    
    func showMenu() {
    
        let menuViewController = MenuViewController()
        menuViewController.modalPresentationStyle = .OverCurrentContext
        self.presentViewController(menuViewController, animated: true, completion: nil)
    }
    
    
}

