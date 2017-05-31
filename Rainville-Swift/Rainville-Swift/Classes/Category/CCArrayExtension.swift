//
//  CCArrayExtension.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 31/05/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import Foundation

extension Array {
    
    public var isArrayValued : Bool {
        get {
            if self.count > 0 {
                return true;
            }
            return false;
        }
    }
    
}
