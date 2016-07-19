//
//  BigTomFartsTableViewCell.swift
//  Big Time Farts
//
//  Created by Perris Davis on 6/25/16.
//  Copyright © 2016 Wikipedia Brown. All rights reserved.
//

import UIKit
import AVFoundation

var playSaveStackView: UIStackView!

var fartRecordingSession = AVAudioSession.sharedInstance()


class BigTomFartsTableViewCell: UITableViewCell, AVAudioRecorderDelegate {
    
    var stackView: UIStackView!
    
//    var fartRecordingSession: AVAudioSession!
    
    var fartRecorder: AVAudioRecorder!
    
    var playRecordedFartButton: UIButton!
    
    var saveRecordedFartButton: UIButton!
    
    var fartPlayer: AVAudioPlayer!
    
    let bigTimeFartsLogo: UIImageView = {
        
        let logo = UIImageView()
        logo.image = UIImage(named: "heart-full")
        logo.contentMode = UIViewContentMode.ScaleAspectFit
        logo.translatesAutoresizingMaskIntoConstraints = false
        return logo
    }()
    
    let recordFart: UIButton = {
        
        let button = UIButton()
        button.backgroundColor = .clearColor()
        button.layer.borderColor = UIColor.whiteColor().CGColor
        button.layer.borderWidth = 2
        button.layer.cornerRadius = 17
        button.setTitle("Record your own fart", forState: .Normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: "BigTomFartsCell")
        
        do {
            
            try fartRecordingSession.setCategory(AVAudioSessionCategoryPlayAndRecord)
            try fartRecordingSession.setActive(true)
            try fartRecordingSession.overrideOutputAudioPort(AVAudioSessionPortOverride.Speaker)
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
        addSubview(bigTimeFartsLogo)
        stackView = UIStackView()
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = UIStackViewDistribution.FillEqually
        stackView.alignment = UIStackViewAlignment.Center
        stackView.axis = .Vertical
        addSubview(stackView)
        
        setupViews()
        
        backgroundColor = UIColor.darkGrayColor()

        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[stackView]-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["stackView": stackView]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[bigTimeFartsLogo]-[stackView]-|", options: NSLayoutFormatOptions.AlignAllCenterX, metrics: nil, views: ["stackView": stackView, "bigTimeFartsLogo": bigTimeFartsLogo]))

    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        //stackView.addArrangedSubview(bigTimeFartsLogo)
        
        stackView.addArrangedSubview(recordFart)
        recordFart.addTarget(self, action: #selector(BigTomFartsTableViewCell.recordFartTapped), forControlEvents: .TouchUpInside)

        playSaveStackView = UIStackView()
        playSaveStackView.spacing = 10
        playSaveStackView.translatesAutoresizingMaskIntoConstraints = false
        playSaveStackView.hidden = true
        playSaveStackView.alpha = 0
        playSaveStackView.axis = .Horizontal
        stackView.addArrangedSubview(playSaveStackView)
        
        
        playRecordedFartButton = UIButton()
        playRecordedFartButton.backgroundColor = .clearColor()
        playRecordedFartButton.translatesAutoresizingMaskIntoConstraints = false
        playRecordedFartButton.setAttributedTitle(makeButtonTitle("Tap to Play"), forState: .Normal)
        playRecordedFartButton.layer.borderWidth = 2
        playRecordedFartButton.layer.borderColor = UIColor.whiteColor().CGColor
        playRecordedFartButton.layer.cornerRadius = 17
        playRecordedFartButton.contentEdgeInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        playRecordedFartButton.addTarget(self, action: #selector(playTapped), forControlEvents: .TouchUpInside)
        playSaveStackView.addArrangedSubview(playRecordedFartButton)
        
        saveRecordedFartButton = UIButton()
        saveRecordedFartButton.backgroundColor = .clearColor()
        saveRecordedFartButton.translatesAutoresizingMaskIntoConstraints = false
        saveRecordedFartButton.setAttributedTitle(makeButtonTitle("Save Fart"), forState: .Normal)
        saveRecordedFartButton.layer.borderWidth = 2
        saveRecordedFartButton.layer.borderColor = UIColor.whiteColor().CGColor
        saveRecordedFartButton.layer.cornerRadius = 17
        saveRecordedFartButton.contentEdgeInsets = UIEdgeInsets(top: 20.0, left: 20.0, bottom: 20.0, right: 20.0)
        saveRecordedFartButton.titleLabel?.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
        saveRecordedFartButton.addTarget(self, action: #selector(saveTapped), forControlEvents: .TouchUpInside)
        playSaveStackView.addArrangedSubview(saveRecordedFartButton)
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[v0]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": recordFart]))
        
        addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[v0]-[v1]-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0": playRecordedFartButton, "v1": saveRecordedFartButton]))

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
        
        print("crap")
        
    }
    
    func recordFartTapped() {
        
        if fartRecorder == nil {
            startRecording()
        } else {
            finishRecording(success: true)
        }
    }
    
    func playTapped() {
        let audioURL = BigTomFartsTableViewCell.getFartURL()
        
        do {
            fartPlayer = try AVAudioPlayer(contentsOfURL: audioURL)
            fartPlayer.play()
        } catch {
            let ac = UIAlertController(title: "Playback failed", message: "There was a problem playing your whistle; please try re-recording.", preferredStyle: .Alert)
            ac.addAction(UIAlertAction(title: "OK", style: .Default, handler: nil))
            //presentViewController(ac, animated: true, completion: nil)
        }
    }
    
    func saveTapped() {
    }
    
    func startRecording() {
        
        recordFart.backgroundColor = .redColor()
        recordFart.setTitleColor(.whiteColor(), forState: .Normal)
        
        recordFart.setTitle("Tap to Stop", forState: .Normal)
        
        let fartURL = BigTomFartsTableViewCell.getFartURL()
        
        let fartSettings = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVEncoderBitRateKey: 320000,
            AVSampleRateKey: 44100.0,
            AVNumberOfChannelsKey: 2 as NSNumber,
            AVEncoderAudioQualityKey: AVAudioQuality.Max.rawValue
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
                self.saveRecordedFartButton.hidden = true
                self.saveRecordedFartButton.alpha = 0
                
                playSaveStackView.hidden = true
                playSaveStackView.alpha = 0
            }
        }
    }
    
    func finishRecording(success success: Bool) {
        recordFart.backgroundColor = .clearColor()
        recordFart.setTitleColor(.redColor(), forState: .Normal)
        
        fartRecorder.stop()
        fartRecorder = nil
        
        if success {
            recordFart.setTitle("Tap to Re-record", forState: .Normal)
            
            if playRecordedFartButton.hidden {
                UIView.animateWithDuration(0.35) { [unowned self] in
                    self.playRecordedFartButton.hidden = false
                    self.playRecordedFartButton.alpha = 1
                    self.saveRecordedFartButton.hidden = false
                    self.saveRecordedFartButton.alpha = 1
                    
                    playSaveStackView.hidden = false
                    playSaveStackView.alpha = 1
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
