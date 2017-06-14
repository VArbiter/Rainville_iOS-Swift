//
//  CCAuthorInfoView.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 01/06/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import UIKit

class CCAuthorInfoView: UIView {

    @IBOutlet private weak var labelAppName: UILabel!
    @IBOutlet private weak var labelVersion: UILabel!
    @IBOutlet private weak var imageViewIcon: UIImageView!
    @IBOutlet private weak var buttonLink: UIButton!
    @IBOutlet private weak var buttonEmail: UIButton!
    
    
    class func initFromNib() -> CCAuthorInfoView? {
        let infoView : CCAuthorInfoView? = Bundle.main.loadNibNamed("CCAuthorInfoView", owner: nil, options: nil)?.first as? CCAuthorInfoView;
        if let infoViewT = infoView {
            infoViewT.frame = CGRect(x: ccScreenWidth() * 2.0, y: 0, width: ccScreenWidth(), height: ccScreenHeight() * 0.3);
            infoViewT.ccDefaultSettings();
            return infoViewT;
        }
        return nil;
    }
    
    private func ccDefaultSettings() {
        self.buttonEmail.titleLabel?.font = UIFont.ccMusketFontWithSize(12.0);
        self.buttonLink.titleLabel?.font = UIFont.ccMusketFontWithSize(12.0);
        let _ = self.labelAppName.ccMusket(12.0, _CC_APP_NAME_());
        let _ = self.labelVersion.ccMusket(12.0, self.ccGetVersionString());
    }
    
    private func ccGetVersionString() -> String {
        let dictionaryInfo : Dictionary = Bundle.main.infoDictionary!;
        return "\(_CC_VERSION_()): \(dictionaryInfo["CFBundleShortVersionString"] ?? "1.0.0")) \(dictionaryInfo["CFBundleVersion"] ?? "1.0.0")";
    }
    
    private func ccRotateImageView() {
        let animation : CABasicAnimation = CABasicAnimation.init(keyPath: "transform.rotation.z");
        animation.fromValue = 0.0;
        animation.toValue = Double.pi * 2.0;
        animation.duration = 0.8;
        animation.autoreverses = false;
        animation.fillMode = kCAFillModeForwards;
        animation.repeatCount = 1;
        self.imageViewIcon.layer.add(animation, forKey: nil);
    }
    
    @IBAction private func ccButtonLinkAction(_ sender: UIButton) {
        let url : URL? = ccURL("https://github.com/VArbiter", false);
        guard (url != nil) else {
            return ;
        }
        if #available(iOS 10, *) {
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.open(url!, options: [:], completionHandler: { (success) in
                    print("success");
                });
            }
        } else {
            if UIApplication.shared.canOpenURL(url!) {
                UIApplication.shared.openURL(url!);
            }
        }
    }

    @IBAction private func ccButtonEmailAction(_ sender: UIButton) {
        //TODO: EMAIL
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touchFocus : UITouch = touches.first!;
        let pointFocus : CGPoint = touchFocus.location(in: self);
        if self.imageViewIcon.frame.contains(pointFocus) {
            self.ccRotateImageView();
        }
    }
    
}
