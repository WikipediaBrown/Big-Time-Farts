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
        self.view.backgroundColor = .whiteColor()
        setupButton()
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
        
        try? fartRecordingSession.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)

        let viewsDictionary = ["v0": fartButton, "v1": menuButton]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-20-[v1]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-20-[v0]-20-[v1(100)]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func playFart() {

        do {
            
            self.fartPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: fartSound)!)
            self.fartPlayer.play()
        } catch {
        
            print("Error getting the fart file: \(error)")
        }
    }
    
    func showMenu() {
    
        let menuViewController = MenuViewController()
        menuViewController.modalPresentationStyle = .OverCurrentContext
        self.presentViewController(menuViewController, animated: true, completion: nil)
    }
    
    
}

