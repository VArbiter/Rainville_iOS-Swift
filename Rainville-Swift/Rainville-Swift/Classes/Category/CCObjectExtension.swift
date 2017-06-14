//
//  CCObjectExtension.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 31/05/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import Foundation

extension NSObject {
    var stringValue : String {
        return String.init(format: "%@", self);
    }
}

extension String {
    
    var isStringValued : Bool {
        get {
            if self.characters.count > 0 {
                return true;
            }
            return false;
        }
    }
    
}

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

extension Array {
    
    var isArrayValued : Bool {
        get {
            if self.count > 0 {
                return true;
            }
            return false;
        }
    }
    
}
