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
    
    public class func ccMusketFontWithSize(float : CGFloat) -> UIFont {
        return UIFont.init(name: "Musket", size: float)!;
    }
    
    public class func ccWeatherIconsWithSize(float : CGFloat) -> UIFont {
        return UIFont.init(name: "Weather Icons", size: float)!;
    }
    
    public class func ccElegantIconsWithSize(float : CGFloat) -> UIFont {
        return UIFont.init(name: "ElegantIcons", size: float)!;
    }
    
}
