//
//  VoiceVieModel.swift
//  Voice Change
//
//  Created by Trần Đức Duy on 16/08/2022.
//

import Foundation
import AVFoundation
import CoreData
import UIKit

class VoiceViewModel: NSObject, ObservableObject, AVAudioPlayerDelegate {
    var audioRecorder : AVAudioRecorder!
    var audioPlayer : AVAudioPlayer!
    
    @Published var isPlaying:Bool = false
    @Published var isCaptupredMode = false
    @Published var isRecording : Bool = false
    @Published var recordingList = [Recording]()
    
    private var time: Double = 0
    @Published var countmin: Int = 0
    @Published var countSec:Int = 0
    var timerCount: Timer
    
    
    //MARK: Properties
    
    @Published var soundSample : [Float]

    private var currentSample: Int
    private var numberOfSamples: Int
    

    var playURL: URL?
//    override init(){
//        super.init()
//           
//           fetchAllRecording()
//           
//       }
    
    
    init(numberOfSamples : Int){
        self.soundSample = [Float](repeating: -50 , count: numberOfSamples)
        self.numberOfSamples = numberOfSamples
        self.currentSample = 0
        self.timerCount = Timer()
    }
    
    func audioPlayerDidFinishPlaying(_ plyer: AVAudioPlayer, successfully flag: Bool){
        
        for i in 0..<recordingList.count{
            if recordingList[i].fileURL == playURL{
                recordingList[i].isPlaying = false
            }
        }
    }
    func startRecording(){
        let recordingSession = AVAudioSession.sharedInstance()
        do{
            try recordingSession.setCategory(.playAndRecord, mode: .default)
            try recordingSession.setActive(true)
            
        }catch {
            print("Can not setup the Recording")
        }
        
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let fileName = path.appendingPathComponent("New recorder: \(Date().toString(dateFormat: "dd-MM-YY'at' HH:mm:ss")).m4a")
        
        let setting: [String : Any] = [
            AVFormatIDKey: Int(kAudioFormatMPEG4AAC),
            AVSampleRateKey: 16000,
            AVNumberOfChannelsKey: 1,
            AVEncoderAudioQualityKey: AVAudioQuality.high.rawValue
        ]
        do{
            audioRecorder = try AVAudioRecorder(url: fileName, settings: setting)
            isRecording = true
            startMonitoring()
            //something
        }catch {
            print("Failed to setup  the recording")
        }
    }
    func stopRecording(){
        audioRecorder.stop()
        
        isRecording = false
        countSec = 0
        countmin = 0
        time = 0
        timerCount.invalidate()
       
        self.soundSample = [Float](repeating: -50, count: numberOfSamples)
        self.currentSample = 0
    }
    private func startMonitoring(){
        audioRecorder.isMeteringEnabled = true
        audioRecorder.record()
        audioRecorder.prepareToRecord()
        if isCaptupredMode {
            var soundSamples = [Float](repeating:  0, count: self.numberOfSamples)
            var count = 0
            timerCount = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
                self.audioRecorder.updateMeters()
                soundSamples[self.currentSample] = self.audioRecorder.averagePower(forChannel: 0)
                self.currentSample = (self.currentSample + 1) % self.numberOfSamples
                
                if count == self.numberOfSamples{
                    self.soundSample = soundSamples
                    soundSamples = [Float](repeating: 0, count: self.numberOfSamples)
                    self.currentSample = 0
                    count = 0
                }
                count += 1
                self.time += 1
                
                self.countSec += Int(self.time * 0.01) % 60
                self.countmin += Int((self.time * 0.01) / 60) % 60
            })
        }else{
            timerCount = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { (timer) in
                self.audioRecorder.updateMeters()
                self.soundSample[self.currentSample] = self.audioRecorder.averagePower(forChannel: 0)
                self.currentSample = (self.currentSample + 1) % self.numberOfSamples
                
                self.time += 1
                self.countSec += Int(self.time * 0.01) % 60
                self.countmin += (Int(self.time * 0.01) / 60) % 60
            })
        }
    }
    
    func fetchAllRecording(){
        let path = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let directoryContents = try! FileManager.default.contentsOfDirectory(at: path, includingPropertiesForKeys: nil)
        for i in directoryContents{
            recordingList.append(Recording(fileURL: i, createdAt: getFileDate(for: i), isPlaying: false))
        }
        recordingList.sort(by: {$0.createdAt.compare($1.createdAt) == .orderedDescending })
    }
    
    
    func startPlaying(url :URL){
        playURL = url
        let playSession = AVAudioSession.sharedInstance()
        
        do{
            try playSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
        }catch {
            print("Playing failed in Device")
        }
        
        do{
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.delegate = self
            audioPlayer.prepareToPlay()
            audioPlayer.play()
            isPlaying = true
        
        
        for i in 0..<recordingList.count{
            if recordingList[i].fileURL == url {
                recordingList[i].isPlaying = true
            }
        }
        }catch{
            print("Playing failed ")
        }
    }
    func stopPlaying(url : URL){
        audioPlayer.stop()
        isPlaying = false
        
        for i in 0..<recordingList.count{
            if recordingList[i].fileURL == url {
                recordingList[i].isPlaying = false
            }
        }
    }
    
    func deleteRecording(url: URL){
        do{
            try FileManager.default.removeItem(at: url)
        }catch {
            print("can't delete")
        }
        
        for i in 0..<recordingList.count{
            if recordingList[i].fileURL == url{
                if recordingList[i].isPlaying == true {
                    stopPlaying(url: recordingList[i].fileURL)
                }
                recordingList.remove(at: i)
                
                break
            }
        }
    }
    
    
    func getFileDate(for file: URL) -> Date {
            if let attributes = try? FileManager.default.attributesOfItem(atPath: file.path) as [FileAttributeKey: Any],
                let creationDate = attributes[FileAttributeKey.creationDate] as? Date {
                return creationDate
            } else {
                return Date()
            }
        }
    deinit{
        if isRecording{
            stopRecording()
        }
    }
    
}


struct Alerts{
    static let SaveThisFile = "Do you want to save this file"
    static let DeleteThisFile = "Do you want to delete this file "
}
extension Date{
    func toString(dateFormat format: String) -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        return dateFormatter.string(from: self)
    }
}


extension VoiceViewModel{
    func convertSecToMinAndHour(seconds: Int) -> String{
        let (_,m,s) = (seconds/3600, (seconds % 3600) / 60, (seconds % 3600) % 60)
        let sec: String = s < 10 ? "0\(s)": "\(s)"
        return "\(m):\(sec)"
    }
}
