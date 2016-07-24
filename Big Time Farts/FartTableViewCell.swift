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
        button.setImage(UIImage(named: "play-button"), forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let fartDescriptionn: UILabel = {
        
        let label = UILabel()
        label.numberOfLines = 0
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let fartSelectedImage: UIImageView = {
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "heart-full")
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
        
        backgroundColor = backColor
        
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
            } catch {
                
                print("Error getting the fart file: \(error)")
            }
            
            self.cellFartPlayer.play()

        } else if cellSection == 2 {
            
            let fartIndexPath = NSIndexPath(forRow: cellIndexPath, inSection: 0)
            
            let cellFart = fetchedFartResultsController.objectAtIndexPath(fartIndexPath) as! Fart
            
            
            
            let documentDirectory = NSURL(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0])
            let originPath = documentDirectory.URLByAppendingPathComponent(cellFart.fartSound!).absoluteString
        
            do {
                
                self.cellFartPlayer = try AVAudioPlayer(contentsOfURL: NSURL(string: originPath)!)
                self.cellFartPlayer.play()
            } catch {
                
                print("Error getting the fart file: \(error)")
            }
        }
    }

}
