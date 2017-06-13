//
//  CCPickerViewExtension.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 01/06/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import Foundation
import UIKit

extension UIPickerView {
    
    func ccCyanSeperateLine() {
        for (_ , value) in self.subviews.enumerated() {
            if value.isKind(of: UIView.self) {
                if value.height < 1.0 {
                    value.backgroundColor = ccHexColor(0x22A1A2);
                    value.height = 2.0;
                }
            }
        }
    }
    
}
