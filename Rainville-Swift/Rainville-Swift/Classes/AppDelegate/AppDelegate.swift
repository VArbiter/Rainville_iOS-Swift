//
//  AppDelegate.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 31/05/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        CCLog(string: NSHomeDirectory());
        
        self.window = UIWindow.init();
        self.window?.frame = UIScreen.main.bounds;
        self.window?.backgroundColor = UIColor.white;
        
        let mainVC = CCBaseViewController.init(nibName: NSStringFromClass(CCBaseViewController.self), bundle: Bundle.main);
        self.window?.rootViewController = mainVC;
        
        self.window?.makeKeyAndVisible();
        
        UIApplication.shared.beginReceivingRemoteControlEvents();
        
        return true
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        if event?.type != UIEventType.remoteControl {
            return;
        }
        var integerOrder : Int;
        let eventSubtype = event?.subtype;
        
        switch eventSubtype! {
            case .remoteControlPause : integerOrder = UIEventSubtype.remoteControlPause.rawValue ;
            case .remoteControlPlay : integerOrder = UIEventSubtype.remoteControlPlay.rawValue ;
            case .remoteControlNextTrack : integerOrder = UIEventSubtype.remoteControlNextTrack.rawValue ;
            case .remoteControlPreviousTrack : integerOrder = UIEventSubtype.remoteControlPreviousTrack.rawValue ;
            case .remoteControlTogglePlayPause : integerOrder = UIEventSubtype.remoteControlTogglePlayPause.rawValue ;
            default: integerOrder = -1;
        }
        
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: _CC_APP_DID_RECEIVE_REMOTE_NOTIFICATION_),
                                        object: nil,
                                        userInfo: Dictionary.init(dictionaryLiteral: ("key",integerOrder)));
        
    }

}

