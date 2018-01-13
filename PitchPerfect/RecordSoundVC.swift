//
//  RecordSoundVC.swift
//  PitchPerfect
//
//  Created by Ludovic Saussinan on 13/1/18.
//  Copyright © 2018 Ludovic Saussinan. All rights reserved.
//

import UIKit
import AVFoundation

class RecordSoundVC: UIViewController, AVAudioRecorderDelegate {
    
    @IBOutlet weak var recordButton: UIButton!
    @IBOutlet weak var tabToRecordLabel: UILabel!
    @IBOutlet weak var stopRecordingButton: UIButton!
    
    var audioRecorder: AVAudioRecorder!
    
    enum RecordingState { case recording, notRecording }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        configureUI(.notRecording)
    }
    
    func configureUI(_ playState: RecordingState){
        switch(playState) {
        case .recording:
            tabToRecordLabel.text = "Recording in Progress..."
            stopRecordingButton.isEnabled = true
            recordButton.isEnabled = false
        case .notRecording:
            stopRecordingButton.isEnabled = false
            recordButton.isEnabled = true
            tabToRecordLabel.text = "Tap to record"
        }
    }
    
    @IBAction func recordAudio(_ sender: Any) {
        configureUI(.recording)
        
        let dirPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let recordingName = "recoredVoice.wav"
        let pathArray = [dirPath, recordingName]
        let filePath = URL(string: pathArray.joined(separator: "/"))
        print(filePath!)
        
        let session = AVAudioSession.sharedInstance()
        try! session.setCategory(AVAudioSessionCategoryPlayAndRecord, with: .defaultToSpeaker)
        
        try! audioRecorder = AVAudioRecorder(url: filePath!, settings: [:])
        audioRecorder.delegate = self
        audioRecorder.isMeteringEnabled = true
        audioRecorder.prepareToRecord()
        audioRecorder.record()
    }
    
    @IBAction func stopRecord(_ sender: Any) {
        configureUI(.notRecording)
        audioRecorder.stop()
        let audioSession = AVAudioSession.sharedInstance()
        try! audioSession.setActive(false)
    }
    
    func audioRecorderDidFinishRecording(_ recorder: AVAudioRecorder, successfully flag: Bool) {
        if flag {
        performSegue(withIdentifier: "showEffectsVC", sender: audioRecorder.url)
        } else {
            print("There has been an error")
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEffectsVC" {
            let playSoundVC = segue.destination as! PlayEffectsVC
            let recordedAudioUrl = sender as! URL
            playSoundVC.recordedAudioUrl = recordedAudioUrl
        }
    }
    
    

}

