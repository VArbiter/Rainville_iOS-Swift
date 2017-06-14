//
//  CCDictionaryExtension.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 31/05/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import Foundation

extension Dictionary {
    
    var isDictionaryValued : Bool {
        get {
            if (self.keys.count > 0
                && self.values.count > 0
                && self.keys.count == self.values.count) {
                return true;
            }
            return false;
        }
    }
    
}
