//
//  CCViewExtension.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 01/06/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    var x : Double {
        set {
            var frame : CGRect = self.frame;
            frame.origin.x = CGFloat(x);
            self.frame = frame;
        }
        get {
            return Double(self.frame.origin.x) ;
        }
    }
    
    var y : Double {
        set {
            var frame : CGRect = self.frame;
            frame.origin.y = CGFloat(y);
            self.frame = frame;
        }
        get {
            return Double(self.frame.origin.y);
        }
    }
    
    var width : Double {
        set {
            var frame : CGRect = self.frame;
            frame.size.width = CGFloat(width);
            self.frame = frame;
        }
        get {
            return Double(self.frame.size.width);
        }
    }
    
    var height : Double {
        set {
            var frame : CGRect = self.frame;
            frame.size.height = CGFloat(height);
            self.frame = frame;
        }
        get {
            return Double(self.frame.size.height);
        }
    }
    
    var origin : CGPoint {
        set {
            var frame : CGRect = self.frame;
            frame.origin = origin;
            self.frame = frame;
        }
        get {
            return self.frame.origin;
        }
    }
    
    var size : CGSize {
        set {
            var frame : CGRect = self.frame;
            frame.size = size;
            self.frame = frame;
        }
        get {
            return self.frame.size;
        }
    }
    
    var left : Double {
        set {
            var frame : CGRect = self.frame;
            frame.origin.x = CGFloat(left);
            self.frame = frame;
        }
        get {
            return Double(self.frame.origin.x);
        }
    }
    
    var right : Double {
        set {
            var frame : CGRect = self.frame;
            frame.origin.x = CGFloat(right) - frame.size.width;
            self.frame = frame;
        }
        get {
            return Double(self.frame.origin.x + self.frame.size.width);
        }
    }
    
    var top : Double {
        set {
            var frame : CGRect = self.frame;
            frame.origin.y = CGFloat(top);
            self.frame = frame;
        }
        get {
            return Double(self.frame.origin.y);
        }
    }
    
    var bottom : Double {
        set {
            var frame : CGRect = self.frame;
            frame.origin.y = CGFloat(bottom) - frame.size.height;
            self.frame = frame;
        }
        get {
            return Double(self.frame.origin.y + self.frame.size.height);
        }
    }
    
}
