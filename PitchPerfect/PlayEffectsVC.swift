//
//  PlayEffectsVC.swift
//  PitchPerfect
//
//  Created by Ludovic Saussinan on 13/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit
import AVFoundation

class PlayEffectsVC: UIViewController {
    
    @IBOutlet weak var snailButton: UIButton!
    @IBOutlet weak var rabbitButton: UIButton!
    @IBOutlet weak var squirrelButton: UIButton!
    @IBOutlet weak var vaderButton: UIButton!
    @IBOutlet weak var parrotButton: UIButton!
    @IBOutlet weak var reverbButton: UIButton!
    @IBOutlet weak var stopButton: UIButton!
    
    var recordedAudioUrl: URL!
    var audioFile: AVAudioFile!
    var audioEngine: AVAudioEngine!
    var audioPlayerNode: AVAudioPlayerNode!
    var stopTimer: Timer!
    
    enum buttonType: Int {case slow = 0, fast, chipmunk, vader, echo, reverb}
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupAudio()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        configureUI(.notPlaying)
    }
    
    @IBAction func playSound(_ sender: UIButton) {
        switch (buttonType(rawValue: sender.tag)!) {
        case .slow:
            playSound(rate: 0.5)
        case .fast:
            playSound(rate: 1.5)
        case .chipmunk:
            playSound(pitch: 1000)
        case .vader:
            playSound(pitch: -1000)
        case .echo:
            playSound(echo: true)
        case .reverb:
            playSound(reverb: true)
        }
        
        configureUI(.playing)
    }
    
    @IBAction func stopSound(_ sender: UIButton) {
        stopAudio()
    }

    

}
