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
    
    public class func initFromNib() -> CCMainHeaderView {
        let viewHeader : CCMainHeaderView? = Bundle.main.loadNibNamed(NSStringFromClass(CCMainHeaderView.self), owner: nil, options: nil)?.first as? CCMainHeaderView;
        viewHeader?.frame = CGRect(x: 0, y: 0, width: ccScreenWidth(), height: ccScreenHeight());
        if viewHeader != nil {
            viewHeader?.ccSetUpDownLabel(bool: true);
            viewHeader?.ccInitSubViewSettings();
            viewHeader?.ccShowIcon();
        }
        return viewHeader!;
    }
    
    public func ccSetUpDownLabel(bool : Bool) -> Void {
        let _ = self.labelUpDown.ccElegantIcons(float: 25.0, string: bool ? "6" : "7");
        self.labelUpDown.sizeToFit();
        
        self.ccSetBackGroundOpaque(bool: !bool);
        self.ccSetBriefInfoHidden(bool: !bool);
    }
    public func ccSetButtonStatus(bool : Bool) -> Void{
//        self.buttonPlayPause
    }
    public func ccIsAudioPlay() -> Bool {
        
    }
    
    private func ccInitSubViewSettings() -> Void {
        
    }
    private func ccShowIcon() -> Void {
        
    }
    private func ccSetBackGroundOpaque(bool : Bool) -> Void {
        
    }
    private func ccSetBriefInfoHidden(bool : Bool) -> Void {
        
    }
    
    @IBAction private func ccButtonPlayPauseAction(_ sender: UIButton) {
    }
    

}
