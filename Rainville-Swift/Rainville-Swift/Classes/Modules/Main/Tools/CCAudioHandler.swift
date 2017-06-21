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
    case none = 0 , play , pause ;
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
    private var arrayVolume : [Float]? ;
    private var arrayAudioPlayer : [AVAudioPlayer] = [];
    private var arrayVolumeFrameValue : [Float]?;
    private var option : CCPlayOption = CCPlayOption.pause;
    private var closure : (() -> Void)? ;
    private var intDisplayCount : Int = 0 ;
    
//MARK: - Public
    func ccSetAudioPlayerWithVolumeArray(_ arrayVolume : [Float]? , _ closure : @escaping () -> Void) {
        guard (arrayVolume != nil) else {
            return;
        }
        self.arrayVolume = arrayVolume;
        
        var arraySilent : Array <Float> = [];
        for item : Float in self.arrayVolume! {
            arraySilent.append(item / 30.0);
        }
        self.arrayVolumeFrameValue = arraySilent;
        self.ccPausePlayingWithCompleteHandler(closure, .play);
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
        case .play:
            self.ccPlay();
        case .pause:
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
        var artImage : MPMediaItemArtwork? ;
        if #available(iOS 10.0, *) {
            artImage = MPMediaItemArtwork.init(boundsSize: image.size) { (size : CGSize) -> UIImage in
                return image;
            }
        } else {
            artImage = MPMediaItemArtwork.init(image: image);
        };
        if let artImageT = artImage {
            ditionary.updateValue(artImageT, forKey: MPMediaItemPropertyArtwork);
        }
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
        self.timer = DispatchSource.makeTimerSource(flags: [], queue: queue);
        
        self.timer.scheduleRepeating(deadline: .now(), interval: .seconds(1), leeway: .seconds(self.intCountTime));
        self.timer.setEventHandler { [unowned self] in
            CC_Debug_Closure {
                print("\n_CC_COUNT_TIME_REMAIN_\(self.intCountTime)_");
            }
            self.intCountTime -= 1;
            let isStop : Bool = self.intCountTime <= 0;
            if isStop {
                self.option = CCPlayOption.pause;
                self.ccInterPause();
                self.timer.cancel();
                self.timer.setCancelHandler(handler: {
                    CC_Safe_UI_Closure(closure, {
                        closure(true , "00 : 00");
                    })
                })
                self.timer = nil;
            }
            CC_Safe_UI_Closure(closure, {
                closure(isStop , self.ccFormatteTime(self.intCountTime));
            })
        }
        self.timer.resume();
    }
    
//MARK: - Private
    private func ccDefaultSettings() {
        let arrayWavFile : Array = ccAudioFilePath();
        self.operationQueue.maxConcurrentOperationCount = arrayWavFile.count;
        for url : URL in arrayWavFile {
            do {
                let player : AVAudioPlayer = try AVAudioPlayer.init(contentsOf: url);
                player.volume = 0.0;
                player.numberOfLoops = -1;
                self.arrayAudioPlayer.append(player);
                player.prepareToPlay();
            }
            catch { }
        }
    }
    @objc private func ccDisplayAction(_ sender : CADisplayLink) {
        if (self.intDisplayCount > 30 || self.intDisplayCount <= 0) {
            self.ccInvalidateDisplayLink();
            if self.option == CCPlayOption.pause {
                for audioPlayer : AVAudioPlayer in self.arrayAudioPlayer {
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
        
        let closure = {(_ volume : Float , _ isAscending : Bool , _ audioPlayer : AVAudioPlayer ) -> Void in
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
        
        guard (self.arrayVolumeFrameValue != nil) else {
            self.ccInvalidateDisplayLink();
            return;
        }
        
        switch self.option {
        case .play:
            self.intDisplayCount += 1;
            for i in 0..<self.arrayAudioPlayer.count {
                closure(self.arrayVolumeFrameValue![i] , true , self.arrayAudioPlayer[i]);
            }
        case .pause:
            self.intCountTime -= 1;
            for i in 0..<self.arrayAudioPlayer.count {
                closure(self.arrayVolumeFrameValue![i] , false , self.arrayAudioPlayer[i]);
            }
        default:
            self.ccInvalidateDisplayLink();
            return;
        }
    }
    
    private func ccPlay() {
        let closure = {
            self.ccInvalidateDisplayLink();
            let _ = self.ccDisplayLink();
        }
        
        let audioPlayer : AVAudioPlayer?  = self.arrayAudioPlayer.first;
        if let audioPlayerT = audioPlayer {
            if audioPlayerT.isPlaying {
                for i in 0..<self.arrayAudioPlayer.count {
                    self.operationQueue.addOperation {
                        let tempPlayer : AVAudioPlayer? = self.arrayAudioPlayer[i];
                        if let tempPlayerT = tempPlayer {
                            tempPlayerT.volume = self.arrayVolume![i];
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
        for item : AVAudioPlayer in self.arrayAudioPlayer {
            item.pause();
        }
        if let closureT = self.closure {
            closureT();
        }
    }
    
    private func ccDisplayLink() -> CADisplayLink {
        self.ccInvalidateDisplayLink();
        let displayLink : CADisplayLink = CADisplayLink.init(target: self, selector: #selector(ccDisplayAction(_ :)));
        if #available(iOS 10.0, *) {
            displayLink.preferredFramesPerSecond = 30
        } else {
            displayLink.frameInterval = 2;
        };
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
            return String(format: "%02ld : %02ld", intMinutes , intSecondsT);
        } else {
            return String(format: "%02ld : %02ld : %02ld", intHours , intMinutes , intSecondsT);
        }
    }
    
}
