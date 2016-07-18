//
//  FartTableViewCell.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/25/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import UIKit
import AVFoundation

class FartTableViewCell: UITableViewCell, AVAudioRecorderDelegate {
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "FartCell")
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//    override func setSelected(selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    var cellSection = 0
    
    var cellIndexPath = 0
    
    let fartPlayButton: UIButton = {
    
        let button = UIButton()
        button.backgroundColor = .blueColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let fartDescriptionn: UILabel = {
        
        let label = UILabel()
        label.backgroundColor = .greenColor()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fartSelectedImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.backgroundColor = .redColor()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    var cellFartPlayer: AVAudioPlayer = {
    
        let player = AVAudioPlayer()
        return player
    }()
    
    
    func setupViews() {
    
        addSubview(fartPlayButton)
        fartPlayButton.addTarget(self, action: #selector(playButtonPressed), forControlEvents: .TouchUpInside)

        addSubview(fartDescriptionn)
        addSubview(fartSelectedImage)
        fartSelectedImage.hidden = true

        let viewsDictionary = ["v0": fartPlayButton, "v1": fartDescriptionn, "v2": fartSelectedImage]
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[v0(40)]-[v1]-[v2(40)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[v0(40)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[v1]-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:[v2(40)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: viewsDictionary))

        
    
    }
    
    func playButtonPressed() {
    
        if cellSection == 1 {
        
            do {
                
                self.cellFartPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: systemFartList[cellIndexPath].fartSound)!)
                self.cellFartPlayer.play()
            } catch {
                
                print("Error getting the fart file: \(error)")
            }
        } else if cellSection == 2 {
        
            do {
                
                self.cellFartPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: userFartList![cellIndexPath].fartSound!)!)
                self.cellFartPlayer.play()
            } catch {
                
                print("Error getting the fart file: \(error)")
            }
        }
    }

}
