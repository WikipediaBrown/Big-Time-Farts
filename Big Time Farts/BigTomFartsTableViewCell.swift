//
//  BigTomFartsTableViewCell.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/25/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import UIKit
import AVFoundation

class BigTomFartsTableViewCell: UITableViewCell, AVAudioRecorderDelegate {
    
    var stackView: UIStackView!
    
    var fartRecorder: AVAudioRecorder!
    
    var playRecordedFartButton: UIButton!
    
    var whistlePlayer: AVAudioPlayer!
    
    let bigTimeFartsLogo: UIImageView = {
        
        let logo = UIImageView()
        logo.image = UIImage(named: "heart-full")
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    let recordFart: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = UIColor.blueColor()
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var fartRecordingSession: AVAudioSession = {
        
        let session = AVAudioSession()
        return session
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "BigTomFartsCell")
        
        fartRecordingSession = AVAudioSession.sharedInstance()
        
        do {
            
            try fartRecordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try fartRecordingSession.setActive(true)
            fartRecordingSession.requestRecordPermission() {[unowned self] (allowed: Bool) -> Void in
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if allowed {
                        
                        self.activateRecordButton()
                    } else {
                        
                        self.deactivateRecordButton()
                    }
                }
                
            }
            
            
        } catch {
            
            self.deactivateRecordButton()
        }
        
        stackView = UIStackView()
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = UIStackViewDistribution.FillEqually
        stackView.alignment = UIStackViewAlignment.Center
        stackView.axis = .Vertical
        addSubview(stackView)
        
        setupViews()

        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[stackView]-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["stackView": stackView]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[stackView]-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["stackView": stackView]))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    func setupViews() {
        
        stackView.addArrangedSubview(bigTimeFartsLogo)
        stackView.addArrangedSubview(recordFart)
        recordFart.addTarget(self, action: #selector(BigTomFartsTableViewCell.recordFartTapped), forControlEvents: .TouchUpInside)
        
        playRecordedFartButton = UIButton()
        playRecordedFartButton.backgroundColor = UIColor.redColor()
        playRecordedFartButton.translatesAutoresizingMaskIntoConstraints = false
        playRecordedFartButton.setTitle("Tap to Play", forState: .Normal)
        playRecordedFartButton.hidden = true
        playRecordedFartButton.alpha = 0
        playRecordedFartButton.titleLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
        playRecordedFartButton.addTarget(self, action: #selector(playTapped), forControlEvents: .TouchUpInside)
        stackView.addArrangedSubview(playRecordedFartButton)
        
        //addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[v1]-[v0(30)]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": recordFart, "v1": bigTimeFartsLogo]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": bigTimeFartsLogo]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": recordFart]))

    }
    
    class func getDocumentsDirectory() -> NSString {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    class func getFartURL() -> NSURL {
        let audioFilename = getDocumentsDirectory().stringByAppendingPathComponent("fart.m4a")
        let audioURL = NSURL(fileURLWithPath: audioFilename)
        
        return audioURL
    }
    
    func activateRecordButton() {
        
        print("poop")
    }
    
    func deactivateRecordButton() {
        
        print("poop")
        
    }
    
    func recordFartTapped() {
        
        if fartRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    func playTapped() {
    
    
    }
    
    func startRecording() {
        
        recordFart.backgroundColor = UIColor.redColor()
        
        recordFart.setTitle("Tap to Stop", forState: .Normal)
        
        let fartURL = BigTomFartsTableViewCell.getFartURL()
        print(fartURL.absoluteString)
        
        let fartSettings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 12000.0,
            AVNumberOfChannelsKey: 1 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.High.rawValue
        ]
        
        do {
            
            fartRecorder = try AVAudioRecorder(URL: fartURL, settings: fartSettings)
            fartRecorder.delegate = self
            fartRecorder.record()
        } catch {
            
            finishRecording(success: false)
        }
        
        if !playRecordedFartButton.hidden {
            UIView.animateWithDuration(0.35) { [unowned self] in
                self.playRecordedFartButton.hidden = true
                self.playRecordedFartButton.alpha = 0
            }
        }
    }
    
    func finishRecording(success success: Bool) {
        recordFart.backgroundColor = UIColor.greenColor()
        
        fartRecorder.stop()
        fartRecorder = nil
        
        if success {
            recordFart.setTitle("Tap to Re-record", forState: .Normal)
            
            if playRecordedFartButton.hidden {
                UIView.animateWithDuration(0.35) { [unowned self] in
                    self.playRecordedFartButton.hidden = false
                    self.playRecordedFartButton.alpha = 1
                }
            }
            
        } else {
            recordFart.setTitle("Tap to Record", forState: .Normal)
            
            let ac = UIAlertController(title: "Record failed", message: "There was a problem recording your whistle; please try again.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            //presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    func audioRecorderDidFinishRecording(recorder: AVAudioRecorder, successfully flag: Bool) {
        if !flag {
            finishRecording(success: false)
        }
    }
    
}
