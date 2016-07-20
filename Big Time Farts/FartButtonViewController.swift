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
    
    var viewWidth: CGFloat!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.view.backgroundColor = backColor
        viewWidth = self.view.frame.width
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
        button.layer.borderColor = primaryColor.CGColor
        button.backgroundColor = secondaryColor
        button.titleLabel?.text = "MENU"
        button.titleLabel?.tintColor = primaryColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var fartPlayer: AVAudioPlayer = {
        
        let player = AVAudioPlayer()
        return player
    }()
    
    func setupButton() {
        let socialButtonStackView = UIStackView()
        let buttonStackView = UIStackView()
        let mainStackView = UIStackView()

        
        let facebookButton: UIButton = {
            
            let button = UIButton()
            button.layer.cornerRadius = socialButtonStackView.frame.size.height/20
            button.backgroundColor = .redColor()
            return button
        }()
        
        let twitterButton: UIButton = {
            
            let button = UIButton()
            button.backgroundColor = .blueColor()
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()
        
        socialButtonStackView.axis = .Horizontal
        socialButtonStackView.spacing = 10
        socialButtonStackView.distribution = .FillEqually
        socialButtonStackView.addArrangedSubview(facebookButton)
        socialButtonStackView.addArrangedSubview(twitterButton)
        
        buttonStackView.axis = .Vertical
        buttonStackView.spacing = 10
        buttonStackView.distribution = .FillEqually
        buttonStackView.translatesAutoresizingMaskIntoConstraints = false
        buttonStackView.addArrangedSubview(socialButtonStackView)
        buttonStackView.addArrangedSubview(menuButton)
        
        mainStackView.alignment = .Center
        mainStackView.axis = .Vertical
        mainStackView.distribution = .FillEqually
        mainStackView.addArrangedSubview(fartButton)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.addArrangedSubview(buttonStackView)
        self.view.addSubview(mainStackView)
        
        fartButton.addTarget(self, action: #selector(FartButtonViewController.playFart), forControlEvents: .TouchUpInside)
        menuButton.addTarget(self, action: #selector(FartButtonViewController.showMenu), forControlEvents: .TouchUpInside)
        
        _ = try? fartRecordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        _ = try? fartRecordingSession.setActive(true)
        _ = try? fartRecordingSession.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
        
        let viewsDictionary = ["v0": mainStackView, "v1": buttonStackView, "v2": socialButtonStackView]
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[v0]-20-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[v1]-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[v2]-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
    }
    
    func playFart() {
        
        do {
            
            self.fartPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: defaults.objectForKey("defaultFart") as! String)!)
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

