//
//  BigTomFartsTableViewCell.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/25/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import UIKit
import AVFoundation

class BigTomFartsTableViewCell: UITableViewCell {

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "BigTomFartsCell")
        setupViews()
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    let recordFart: UIButton = {
    
        let button = UIButton()
        button.backgroundColor = UIColor.blueColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let bigTimeFartsLogo: UIImageView = {
        
        let logo = UIImageView()
        logo.image = UIImage(named: "heart-full")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    let fartRecorder: AVAudioRecorder = {
        
        let recorder = AVAudioRecorder()
        return recorder
    }()
    
    
    func setupViews() {
    
        addSubview(recordFart)
        addSubview(bigTimeFartsLogo)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[v1]-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": recordFart, "v1": bigTimeFartsLogo]))
        
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": recordFart]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": bigTimeFartsLogo]))
    }
    
    func setupFartRecorder() {
        
        let fartPath = NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first!
        let pathComponents = [fartPath, "newFart.mp3"]
        let audioURL = NSURL.fileURLWithPathComponents(pathComponents)
        
        
    
    }

}
