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

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "BigTomFartsCell")
        setupViews()
        
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
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
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
    
    var fartRecorder: AVAudioRecorder!
    
    
    func setupViews() {
    
        addSubview(recordFart)
        recordFart.addTarget(self, action: #selector(BigTomFartsTableViewCell.recordFartTapped), forControlEvents: .TouchUpInside)

        addSubview(bigTimeFartsLogo)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[v1]-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": recordFart, "v1": bigTimeFartsLogo]))
        
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": recordFart]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": bigTimeFartsLogo]))
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
    }
    
    func finishRecording(success success: Bool) {
        recordFart.backgroundColor = UIColor.greenColor()
        
        fartRecorder.stop()
        fartRecorder = nil
        
        if success {
            recordFart.setTitle("Tap to Re-record", forState: .Normal)
            //navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Next", style: .Plain, target: self, action: #selector(nextTapped))
        } else {
            recordFart.setTitle("Tap to Record", forState: .Normal)
            
            let ac = UIAlertController(title: "Record failed", message: "There was a problem recording your whistle; please try again.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            //presentViewController(ac, animated: true, completion: nil)
        }
    }

}
