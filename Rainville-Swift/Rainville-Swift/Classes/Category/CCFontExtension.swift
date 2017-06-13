//
//  CCFontExtension.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 01/06/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import Foundation
import UIKit

extension UIFont {
    
    class func ccMusketFontWithSize(_ floatSize : CGFloat) -> UIFont? {
        return self.init(name: "Musket", size: floatSize);
    }
    
    class func ccWeatherIconsWithSize(_ floatSize : CGFloat) -> UIFont? {
        return self.init(name: "Weather Icons", size: floatSize);
    }
    
    class func ccElegantIconsWithSize(_ floatSize : CGFloat) -> UIFont? {
        return self.init(name: "ElegantIcons", size: floatSize);
    }
    
}
