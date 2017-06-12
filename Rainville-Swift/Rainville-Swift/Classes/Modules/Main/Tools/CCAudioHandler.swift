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
    public static let sharedInstance : CCAudioHandler = CCAudioHandler.sharedAudioHandler();
    private class func sharedAudioHandler() -> CCAudioHandler {
        return CCAudioHandler.init();
    }
    private override init() {}
    
//MARK: - 
    
    private lazy var operationQueue: OperationQueue! = {
        return OperationQueue.init();
    }()
    private var displayLink : CADisplayLink? ;
    private var timer : DispatchSourceTimer! ;
    private var intCountTime : Int! = 0;
    private var arrayVolume : Array<Double>! ;
    private var arrayAudioPlayer : Array<AVAudioPlayer>! ;
    private var arrayVolumeFrameValue : Array<Double>! ;
    private var option : CCPlayOption! = CCPlayOption.CCPlayOptionPause;
    private var closure : (() -> Void)? ;
    private var intDisplayCount : Int! = 0 ;
    
//MARK: - Public
    func ccSetAudioPlayerWithVolumeArray(_ arrayVolume : Array<Double> , _ closure : @escaping () -> Void) {
        self.arrayVolume = arrayVolume;
        
        var arraySilent : Array <Double> = [];
        for item : Double in self.arrayVolume {
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
            self.intCountTime! -= 1;
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
    private func ccDisplayAction(_ sender : CADisplayLink) {
        if (self.intDisplayCount > 30 || self.intDisplayCount <= 0) {
            self.ccInvalidateDisplayLink();
            if self.option == CCPlayOption.CCPlayOptionPause {
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
        
//TODO: - 
    }
    
    private func ccPlay() {
        
    }
    private func ccPause() {
        
    }
    private func ccInterPause() {
        
    }
    
    private func ccDisplayLink() -> CADisplayLink {
        
    }
    private func ccInvalidateDisplayLink() {
        
    }
    
    private func ccFormatteTime(_ intSeconds : Int) -> String {
        
    }
    
}
