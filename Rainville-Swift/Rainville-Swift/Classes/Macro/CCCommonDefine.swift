//
//  CCCommonDefine.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 31/05/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import Foundation
import UIKit

let _CC_APP_DID_RECEIVE_REMOTE_NOTIFICATION_ : String = "CC_APP_DID_RECEIVE_REMOTE_NOTIFICATION";

typealias CCCommonClosure = (Bool , Any?) -> Void ;

func CCLog <T> (_ string : T ,
            stringFileName : String = #file ,
            stringFunction : String = #function ,
            integerLine : Int = #line) -> Void {
#if DEBUG
        print("_CC_LOG_ \n\(stringFileName) \n\(stringFunction) \n\(integerLine) \n\(string)");
#endif
}

func ccScreenWidth() -> Double {
    return Double(UIScreen.main.bounds.size.width);
}

func ccScreenHeight() -> Double {
    return Double(UIScreen.main.bounds.size.height);
}

func ccHexColor(_ int : Int) -> UIColor {
    return ccHexColorAlpha(int, 1.0);
}

func ccHexColorAlpha(_ int : Int ,_ floatAlpha : Float) -> UIColor {
    return ccRGBAColor(Float((int & 0xFF0000) >> 16) / 255.0,
                       Float((int & 0xFF00) >> 8) / 255.0,
                       Float(int & 0xFF) / 255.0,
                       floatAlpha);
}

func ccRGBColor(_ R : Float ,_ G : Float ,_ B : Float) -> UIColor {
    return ccRGBAColor(R, G, B, 1.0);
}

func ccRGBAColor(_ R : Float ,_ G : Float ,_ B : Float ,_ A : Float) -> UIColor {
    return UIColor.init(colorLiteralRed: R, green: G, blue: B, alpha: A);
}

func ccURL (_ string : String ,_ isFile : Bool) -> URL? {
    if !string.isStringValued {
        return nil; 
    }
    if isFile {
        return URL.init(fileURLWithPath: string);
    }
    return URL.init(string: string);
}

func ccImage(_ string : String) -> UIImage{
    return ccImageWithCache(string, true);
}

func ccImageWithCache(_ string : String ,_ isCache : Bool) -> UIImage {
    if isCache {
        return UIImage.init(named: string)!;
    }
    return UIImage.init(contentsOfFile: string)!;
}

func CC_Safe_UI_Closure(_ closureNil : Any? ,_ closure : () -> Void) {
    guard (closureNil != nil) else {
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

func CC_Safe_Closure(_ closureNil : Any? ,_ closure : () -> Void){
    guard (closureNil != nil) else {
        return ;
    }
    closure() ;
}

func CC_Debug_Closure(_ closure : () -> Void) {
#if DEBUG
    closure();
#endif
}

func ccLocalizeString(_ string : String , _ : String) -> String {
    return NSLocalizedString(string, comment: "");
}
