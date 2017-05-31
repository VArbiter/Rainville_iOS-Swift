//
//  CCCommonDefine.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 31/05/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import Foundation
import UIKit

let _CC_APP_DID_RECEIVE_REMOTE_NOTIFICATION_ = "CC_APP_DID_RECEIVE_REMOTE_NOTIFICATION";

typealias CCCommonClosure = (Bool , Any) -> Void ;
//typealias CCCommonClosure = (Bool , Any) ;

public func CCLog <T> (stringMessage : T ,
                   stringFileName : String = #file ,
                   stringFunction : String = #function ,
                   integerLine : Int = #line) -> Void {
    #if DEBUG
        print("_CC_LOG_ \n\(stringFileName) \n\(stringFunction) \n\(integerLine) \n\(stringMessage)");
    #endif
}

public func ccStringFormat<T>(stringFormat : T) -> String {
    return String.init(format: "%@", stringFormat as! CVarArg);
}

public func ccScreenWidth() -> Double {
    return Double(UIScreen.main.bounds.size.width);
}

public func ccScreenHeight() -> Double {
    return Double(UIScreen.main.bounds.size.height);
}

public func ccHexColor(intValue : Int) -> UIColor {
    return ccHexColorAlpha(intValue: intValue, floatAlpha: 1.0);
}

public func ccHexColorAlpha(intValue : Int , floatAlpha : Float) -> UIColor {
    return UIColor.init(colorLiteralRed: Float(intValue & 0xFF0000 >> 16) / 255.0 ,
                        green:  Float(intValue & 0xFF00 >> 16) / 255.0,
                        blue:  Float(intValue & 0xFF >> 16) / 255.0,
                        alpha: floatAlpha);
}

public func ccRGBColor(R : Float , G : Float , B : Float) -> UIColor{
    return ccRGBAColor(R: R, G: G, B: B, A: 1.0);
}

public func ccRGBAColor(R : Float , G : Float , B : Float , A : Float) -> UIColor {
    return UIColor.init(colorLiteralRed: R, green: G, blue: B, alpha: A);
}

public func ccURL (string : String , isFile : Bool) -> URL {
    if !string.isStringValued {
        return Optional.none!; // 为 nil
    }
    if isFile {
        return URL.init(fileURLWithPath: string);
    }
    return URL.init(string: string)!;
}

public func ccImage(string : String) -> UIImage{
    return ccImageWithCache(string: string, isCache: true);
}

public func ccImageWithCache(string : String , isCache : Bool) -> UIImage {
    if isCache {
        return UIImage.init(named: string)!;
    }
    return UIImage.init(contentsOfFile: string)!;
}

public func ccSafeUIClosure(closureNil : Any , closure : @escaping () -> Void) -> Void {
    if (closureNil == Optional.none!
        || closure == Optional.none!) {
        return ;
    }
    
    if Thread.isMainThread {
        closure();
    }
    else {
        DispatchQueue.main.sync {
            closure();
        }
    }
}

public struct CCCommonDefine {
    
}
