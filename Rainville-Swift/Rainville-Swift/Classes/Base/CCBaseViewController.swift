//
//  CCBaseViewController.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 31/05/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import UIKit

class CCBaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    class func ccStringControllerName() -> String {
        return NSStringFromClass(self) as String;
    }
    
    func ccStringEntityControllerName() -> String {
        let object : AnyObject = self;
        let name : AnyClass = objc_getClass(object as! UnsafePointer<Int8>) as! AnyClass;
        return NSStringFromClass(name);
    }
    
    deinit {
        CCLog(stringMessage: "_CC_\(self.ccStringEntityControllerName())_DELLOC_");
    }
    
}
