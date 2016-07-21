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
    
//    let fartButton: UIImageView = {
//        
//        let button = UIImageView()
//        button.image = UIImage(named: "heart-full")
//        button.contentMode = UIViewContentMode.ScaleAspectFit
//        button.backgroundColor = .redColor()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        return button
//    }()
    
    let fartButton: UIButton = {
        
        let button = UIButton()
//        button.setImage(UIImage(named: "heart-full"), forState: .Normal)
        button.setBackgroundImage(UIImage(named: "heart-full"), forState: .Normal)
        button.contentMode = UIViewContentMode.ScaleAspectFit
        button.backgroundColor = .redColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let menuButton: UIButton = {
        
        let button = UIButton()
        button.layer.cornerRadius = 17
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .Center
        button.backgroundColor = secondaryColor
        button.setAttributedTitle(makeMenuButton("Big Tom Farts\nmenu"), forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var fartPlayer: AVAudioPlayer = {
        
        let player = AVAudioPlayer()
        return player
    }()
    
    func setupButton() {
        let socialButtonStackView = UIStackView()
        let facebookButton: UIButton = {
            
            let button = UIButton(frame: CGRect(x: 0, y: 0, width: self.view.frame.height/10, height: self.view.frame.height/10))
            button.layer.cornerRadius = (self.view.frame.width)/20
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
        socialButtonStackView.translatesAutoresizingMaskIntoConstraints = false
        
        
        
        self.view.addSubview(fartButton)
        
        self.view.addSubview(menuButton)

        self.view.addSubview(socialButtonStackView)

        
//        fartButton.addTarget(self, action: #selector(FartButtonViewController.playFart), forControlEvents: .TouchUpInside)
        menuButton.addTarget(self, action: #selector(FartButtonViewController.showMenu), forControlEvents: .TouchUpInside)
        
        _ = try? fartRecordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
        _ = try? fartRecordingSession.setActive(true)
        _ = try? fartRecordingSession.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
        
        let viewsDictionary = ["v0": fartButton, "v1": socialButtonStackView, "v2": menuButton]
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-\(statusBarHeight)-[v0]-[v1]-[v2]-16-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        
        self.view.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))

        
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

