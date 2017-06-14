//
//  CCMainHeaderView.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 01/06/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import UIKit

protocol CCPlayActionDelegate {
    func ccHeaderButtonActionWithPlayOrPause(bool : Bool) -> Void ;
}

class CCMainHeaderView: UIView {
    
    var delegate : CCPlayActionDelegate? ;
    
    @IBOutlet private weak var viewBackground: UIView!
    @IBOutlet private weak var labelUpDown: UILabel!
    @IBOutlet private weak var labelIcon: UILabel!
    @IBOutlet private weak var buttonPlayPause: UIButton!
    @IBOutlet private weak var labelDesc: UILabel!
    @IBOutlet private weak var viewLightLine: UIView!
    @IBOutlet private weak var labelAppName: UILabel!
    @IBOutlet weak var labelCountDown: UILabel!
    
    class func initFromNib() -> CCMainHeaderView? {
        let viewHeader : CCMainHeaderView? = Bundle.main.loadNibNamed("CCMainHeaderView", owner: nil, options: nil)?.first as? CCMainHeaderView;
        viewHeader?.frame = CGRect(x: 0, y: 0, width: ccScreenWidth(), height: ccScreenHeight());
        if let viewHeaderT = viewHeader {
            viewHeaderT.ccSetUpDownLabel(true);
            viewHeaderT.ccInitSubViewSettings();
            viewHeaderT.ccShowIcon();
            return viewHeaderT;
        }
        return nil;
    }
    
    func ccSetUpDownLabel(_ bool : Bool) {
        let _ = self.labelUpDown.ccElegantIcons(25.0, bool ? "6" : "7");
        self.labelUpDown.sizeToFit();
        
        self.ccSetBackGroundOpaque(!bool);
        self.ccSetBriefInfoHidden(!bool);
    }
    func ccSetButtonStatus(bool : Bool) {
        self.buttonPlayPause.isSelected = bool;
        self.buttonPlayPause.backgroundColor = ccHexColor(bool ? 0x22A1A2 : 0x333333);
    }
    func ccIsAudioPlay() -> Bool {
        return self.buttonPlayPause.isSelected;
    }
    
    private func ccInitSubViewSettings() {
        let isContainEnglish : Bool = _CC_LANGUAGE_().contains("English");
        
        if isContainEnglish {
            let _ = self.labelAppName.ccMusket(30.0, _CC_APP_NAME_());
        } else {
            self.labelAppName.text = _CC_APP_NAME_();
        }
        self.labelAppName.sizeToFit();
        
        let _ = self.labelDesc.ccMusketWithString(_CC_APP_DESP_());
        self.labelDesc.sizeToFit();
        
        let _ = self.labelIcon.ccWeatherIcons(70.0, "\u{f006}"); // 特殊字体调用
        self.labelIcon.sizeToFit();
        
        let _ = self.labelCountDown.ccMusket(25.0, "00 : 00");
        self.labelCountDown.isHidden = true;
        
        if isContainEnglish {
            self.buttonPlayPause.titleLabel?.font = UIFont.ccMusketFontWithSize(15.0);
        }
        self.buttonPlayPause.setTitle(_CC_PLAY_(), for: UIControlState.normal);
        self.buttonPlayPause.setTitle(_CC_STOP_(), for: UIControlState.selected);
        self.buttonPlayPause.width = self.labelIcon.width - 20.0;
    }
    private func ccShowIcon() {
        self.labelIcon.alpha = 0.0;
        weak var pSelf = self;
        UIView.animate(withDuration: 1.0) {
            pSelf?.labelIcon.alpha = 1.0;
        };
    }
    private func ccSetBackGroundOpaque(_ bool : Bool) {
        weak var pSelf = self;
        UIView.animate(withDuration: 0.5) { 
            pSelf?.viewBackground.alpha = bool ? 0.65 : 0.95;
        }
    }
    private func ccSetBriefInfoHidden(_ bool : Bool) {
        weak var pSelf = self;
        UIView.animate(withDuration: 0.5) { 
            pSelf?.labelAppName.alpha = bool ? 0.0 : 1.0 ;
            pSelf?.labelDesc.alpha = bool ? 0.0 : 1.0 ;
            pSelf?.viewLightLine.alpha = bool ? 0.0 : 1.0 ;
        };
    }
    
    @IBAction private func ccButtonPlayPauseAction(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected;
        
        sender.backgroundColor = ccHexColor(sender.isSelected ? 0x22A1A2 : 0x333333);
        
        self.delegate?.ccHeaderButtonActionWithPlayOrPause(bool: sender.isSelected);
    }
    
}
