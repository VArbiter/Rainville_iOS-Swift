//
//  CCLabelExtension.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 01/06/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import Foundation
import UIKit

let _CC_SYSTEM_FONT_SIZE_ : CGFloat = 17.0 ;

extension UILabel {
    
    public func ccMusketWithString(string : String) -> UILabel {
        return self.ccMusket(float: _CC_SYSTEM_FONT_SIZE_, string: string);
    }
    
    public func ccMusket(float : CGFloat , string : String) -> UILabel {
        self.font = UIFont.ccMusketFontWithSize(float: float);
        self.text = string;
        return self;
    }
    
    public func ccWeatherIconsWithString(string : String) -> UILabel {
        return self.ccWeatherIcons(float: _CC_SYSTEM_FONT_SIZE_, string: string);
    }
    
    public func ccWeatherIcons(float : CGFloat , string : String) -> UILabel {
        self.font = UIFont.ccWeatherIconsWithSize(float: float);
        self.text = string;
        return self;
    }
    
    public func ccElegantIconsWithString(string : String) -> UILabel {
        return self.ccElegantIcons(float: _CC_SYSTEM_FONT_SIZE_, string: string);
    }
    
    public func ccElegantIcons(float : CGFloat , string : String) -> UILabel {
        self.font = UIFont.ccElegantIconsWithSize(float: float);
        self.text = string;
        return self;
    }
    
}
