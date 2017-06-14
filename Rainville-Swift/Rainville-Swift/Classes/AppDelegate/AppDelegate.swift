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
        CCLog(NSHomeDirectory());
        
        self.window = UIWindow.init(frame: UIScreen.main.bounds);
        if let windowT = self.window {
            windowT.frame = UIScreen.main.bounds;
            windowT.backgroundColor = UIColor.white;
            
            windowT.rootViewController = CCMainViewController.init(nibName: "CCMainViewController", bundle: Bundle.main);
            windowT.makeKeyAndVisible();

            application.beginReceivingRemoteControlEvents();
            
            return true;
        }
        return false;
    }
    
    override func remoteControlReceived(with event: UIEvent?) {
        
        if let eventT = event {
            if eventT.type != UIEventType.remoteControl {
                return;
            }
            
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: _CC_APP_DID_RECEIVE_REMOTE_NOTIFICATION_),
                                            object: nil,
                                            userInfo: Dictionary.init(dictionaryLiteral: ("key",eventT.subtype)));
        }
    }

}

