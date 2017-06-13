//
//  CCAudioHandler.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 12/06/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import UIKit
import AVFoundation
import MediaPlayer

enum CCPlayOption : Int {
    case CCPlayOptionNone = 0 , CCPlayOptionPlay , CCPlayOptionPause ;
}

class CCAudioHandler: NSObject {
    
    /// 单例
    static let sharedInstance : CCAudioHandler = CCAudioHandler.sharedAudioHandler();
    private class func sharedAudioHandler() -> CCAudioHandler {
        return CCAudioHandler.init();
    }
    private override init() {
        super.init()
        self.ccDefaultSettings();
    }
    
//MARK: -
    private lazy var operationQueue: OperationQueue! = {
        return OperationQueue.init();
    }()
    private var displayLink : CADisplayLink? ;
    private var timer : DispatchSourceTimer! ;
    private var intCountTime : Int = 0;
    private var arrayVolume : Array<Double>? ;
    private var arrayAudioPlayer : Array<AVAudioPlayer>?;
    private var arrayVolumeFrameValue : Array<Double>?;
    private var option : CCPlayOption = CCPlayOption.CCPlayOptionPause;
    private var closure : (() -> Void)? ;
    private var intDisplayCount : Int = 0 ;
    
//MARK: - Public
    func ccSetAudioPlayerWithVolumeArray(_ arrayVolume : Array<Double>? , _ closure : @escaping () -> Void) {
        guard (arrayVolume != nil) else {
            return;
        }
        self.arrayVolume = arrayVolume;
        
        var arraySilent : Array <Double> = [];
        for item : Double in self.arrayVolume! {
            arraySilent.append(item / 30.0);
        }
        self.arrayVolumeFrameValue = arraySilent;
        self.ccPausePlayingWithCompleteHandler(closure, CCPlayOption.CCPlayOptionPlay);
    }
    func ccPausePlayingWithCompleteHandler(_ closure : @escaping () -> Void ,_ option : CCPlayOption) {
        self.option = option;
        self.closure = closure;
        
        let closureTemp = { () -> Void in
            if let closureT = self.closure {
                closureT();
            }
        }
        self.ccInvalidateDisplayLink();
        switch option {
        case .CCPlayOptionNone:
            closureTemp();
        case .CCPlayOptionPlay:
            self.ccPlay();
        case .CCPlayOptionPause:
            self.ccPause();
        default:
            closureTemp();
            break;
        }
    }
    func ccSetInstantPlayingInfo(_ stringKey : String) {
        var ditionary : Dictionary<String , Any>! = [:];
        ditionary.updateValue(stringKey, forKey: MPMediaItemPropertyTitle);
        ditionary.updateValue(_CC_APP_NAME_(), forKey: MPMediaItemPropertyArtist);
        
        let image : UIImage! = UIImage.init(named: "ic_launcher_144");
        let artImage : MPMediaItemArtwork! = MPMediaItemArtwork.init(boundsSize: image.size) { (size : CGSize) -> UIImage in
            return image;
        };
        ditionary.updateValue(artImage, forKey: MPMediaItemPropertyArtwork);
        MPNowPlayingInfoCenter.default().nowPlayingInfo = ditionary;
    }
    
    func ccSetAutoStopWithSeconds(_ intSeconds : Int ,_ closure : @escaping CCCommonClosure) {
        if let timerT = self.timer {
            timerT.cancel();
            self.timer = nil;
        }
        
        if intSeconds == 0 {
            self.intCountTime = 0 ;
            CC_Safe_Closure(closure, { 
                closure(true , "00 : 00");
            });
            if let timerT = self.timer {
                timerT.cancel();
                self.timer = nil;
            }
            return ;
        }
        
        self.intCountTime = intSeconds;
        let queue : DispatchQueue = DispatchQueue.global(qos: .default);
        self.timer = DispatchSource.makeTimerSource(queue: queue);
        
        let intervalTime : DispatchTimeInterval = .seconds(self.intCountTime);
        self.timer.scheduleRepeating(deadline: .now() + intervalTime, interval: intervalTime);
        self.timer.setEventHandler { [unowned self] in
            self.intCountTime -= 1;
            let isStop : Bool = self.intCountTime <= 0;
            if isStop {
                self.option = CCPlayOption.CCPlayOptionPause;
                self.ccInterPause();
                self.timer.cancel();
                self.timer.setCancelHandler(handler: { 
                    CC_Safe_Closure(closure, {
                        closure(true , "00 : 00");
                    })
                })
                self.timer = nil;
            }
            CC_Safe_Closure(closure, { 
                closure(isStop , self.ccFormatteTime(self.intCountTime));
            })
        }
        self.timer.resume();
    }
    
//MARK: - Private
    private func ccDefaultSettings() {
        if (self.arrayAudioPlayer?.count)! > 0 {
            self.arrayAudioPlayer!.removeAll();
        }
        self.arrayAudioPlayer = [];
        let arrayWavFile : Array = ccAudioFilePath();
        self.operationQueue.maxConcurrentOperationCount = arrayWavFile.count;
        for url : URL in arrayWavFile {
            self.operationQueue.addOperation { [unowned self] in
                do {
                    let player : AVAudioPlayer = try AVAudioPlayer.init(contentsOf: url);
                    player.volume = 0.0;
                    player.numberOfLoops = -1;
                    self.arrayAudioPlayer!.append(player);
                    player.prepareToPlay();
                }
                catch { }
            }
        }
    }
    @objc private func ccDisplayAction(_ sender : CADisplayLink) {
        if (self.intDisplayCount > 30 || self.intDisplayCount <= 0) {
            self.ccInvalidateDisplayLink();
            if self.option == CCPlayOption.CCPlayOptionPause {
                for audioPlayer : AVAudioPlayer in self.arrayAudioPlayer! {
                    self.operationQueue.addOperation {
                        audioPlayer.pause();
                    }
                }
                if let closure = self.closure {
                    closure();
                }
                return;
            }
        }
        
        let closure = { [unowned self] (_ volume : Float , _ isAscending : Bool , _ audioPlayer : AVAudioPlayer ) -> () in
            self.operationQueue.addOperation {
                if isAscending {
                    if (!audioPlayer.isPlaying) {
                        audioPlayer.play();
                    }
                    audioPlayer.volume += volume;
                } else {
                    audioPlayer.volume -= volume;
                }
            }
        }
        
        switch self.option {
        case .CCPlayOptionNone:
            self.ccInvalidateDisplayLink();
            return;
        case .CCPlayOptionPlay:
            self.intDisplayCount += 1;
            for i in 0..<self.arrayAudioPlayer!.count {
                closure(Float(self.arrayVolumeFrameValue![i]) , true , self.arrayAudioPlayer![i]);
            }
        case .CCPlayOptionPause:
            self.intCountTime -= 1;
            for i in 0..<self.arrayAudioPlayer!.count {
                closure(Float(self.arrayVolumeFrameValue![i]) , false , self.arrayAudioPlayer![i]);
            }
        default:
            self.ccInvalidateDisplayLink();
            return;
        }
    }
    
    private func ccPlay() {
        let closure = { [unowned self] in
            self.ccInvalidateDisplayLink();
            let _ = self.ccDisplayLink();
        }
        
        let audioPlayer : AVAudioPlayer?  = self.arrayAudioPlayer?.first;
        if let audioPlayerT = audioPlayer {
            if audioPlayerT.isPlaying {
                for i in 0..<self.arrayAudioPlayer!.count {
                    self.operationQueue.addOperation {
                        let tempPlayer : AVAudioPlayer? = self.arrayAudioPlayer?[i];
                        if let tempPlayerT = tempPlayer {
                            tempPlayerT.volume = Float(self.arrayVolume![i]);
                        }
                    }
                }
                if let closureT = self.closure {
                    closureT();
                }
                return;
            }
        }
        closure();
    }
    private func ccPause() {
        self.intDisplayCount = 0;
        self.ccInvalidateDisplayLink();
        let _ = self.ccDisplayLink();
    }
    private func ccInterPause() {
        self.intCountTime = 0;
        self.ccInvalidateDisplayLink();
        for item : AVAudioPlayer in self.arrayAudioPlayer! {
            item.pause();
        }
        if let closureT = self.closure {
            closureT();
        }
    }
    
    private func ccDisplayLink() -> CADisplayLink {
        self.ccInvalidateDisplayLink();
        let displayLink : CADisplayLink = CADisplayLink.init(target: self, selector: #selector(ccDisplayAction(_ :)));
        displayLink.preferredFramesPerSecond = 30;
        displayLink.add(to: .current, forMode: .commonModes);
        self.displayLink = displayLink;
        return displayLink;
    }
    private func ccInvalidateDisplayLink() {
        guard (self.displayLink != nil) else {
            return;
        }
        self.displayLink?.isPaused = true;
        self.displayLink?.remove(from: .current, forMode: .commonModes);
        self.displayLink?.invalidate();
        self.displayLink = nil;
        self.intDisplayCount = 0;
    }
    
    private func ccFormatteTime(_ intSeconds : Int) -> String {
        let intSecondsT : Int = intSeconds % 60;
        let intMinutes : Int = (intSeconds / 60) % 60;
        let intHours : Int = intSeconds / 3600 ;
        if intHours < 1 {
            return ccStringFormat("%02ld : %02ld", intMinutes , intSecondsT);
        } else {
            return ccStringFormat("%02ld : %02ld : %02ld", intHours , intMinutes , intSecondsT);
        }
    }
    
}
