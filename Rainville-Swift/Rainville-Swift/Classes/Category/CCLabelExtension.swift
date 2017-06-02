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
    
    public func ccMusketWithString(_ string : String) -> UILabel {
        return self.ccMusket(_CC_SYSTEM_FONT_SIZE_, string);
    }
    
    public func ccMusket(_ float : CGFloat ,_ string : String) -> UILabel {
        self.font = UIFont.ccMusketFontWithSize(float);
        self.text = string;
        return self;
    }
    
    public func ccWeatherIconsWithString(_ string : String) -> UILabel {
        return self.ccWeatherIcons(_CC_SYSTEM_FONT_SIZE_, string);
    }
    
    public func ccWeatherIcons(_ float : CGFloat ,_ string : String) -> UILabel {
        self.font = UIFont.ccWeatherIconsWithSize(float);
        self.text = string;
        return self;
    }
    
    public func ccElegantIconsWithString(_ string : String) -> UILabel {
        return self.ccElegantIcons(_CC_SYSTEM_FONT_SIZE_, string);
    }
    
    public func ccElegantIcons(_ float : CGFloat ,_ string : String) -> UILabel {
        self.font = UIFont.ccElegantIconsWithSize(float);
        self.text = string;
        return self;
    }
    
}
