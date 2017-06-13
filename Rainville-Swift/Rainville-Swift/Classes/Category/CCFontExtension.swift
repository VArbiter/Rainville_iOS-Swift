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
    
    class func ccMusketFontWithSize(_ float : CGFloat) -> UIFont? {
        return UIFont.init(name: "Musket", size: float);
    }
    
    class func ccWeatherIconsWithSize(_ float : CGFloat) -> UIFont? {
        return UIFont.init(name: "Weather Icons", size: float);
    }
    
    class func ccElegantIconsWithSize(_ float : CGFloat) -> UIFont? {
        return UIFont.init(name: "ElegantIcons", size: float);
    }
    
}
