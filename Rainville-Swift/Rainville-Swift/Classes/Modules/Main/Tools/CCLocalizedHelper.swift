//
//  CCLocalizedHelper.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 31/05/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import Foundation

public func _CC_LANGUAGE_() -> String {
    return ccLocalizeString(string: "_CC_LANGUAGE_", "");
}
public func _CC_APP_NAME_() -> String {
    return ccLocalizeString(string: "_CC_APP_NAME_", "");
}
public func _CC_APP_DESP_() -> String {
    return ccLocalizeString(string: "_CC_APP_DESP_", "");
}

public func _CC_RAIN_POEM_() -> String {
    return ccLocalizeString(string: "_CC_RAIN_POEM_", "");
}

public func _CC_PLAY_() -> String{
    return ccLocalizeString(string: "_CC_PLAY_", "");
}
public func _CC_STOP_() -> String{
    return ccLocalizeString(string: "_CC_STOP_", "");
}
public func _CC_CONFIRM_() -> String{
    return ccLocalizeString(string: "_CC_CONFIRM_", "");
}
public func _CC_CANCEL_() -> String{
    return ccLocalizeString(string: "_CC_CANCEL_", "");
}
public func _CC_SET_CLOSE_TIMER_() -> String{
    return ccLocalizeString(string: "_CC_SET_CLOSE_TIMER_", "");
}
public func _CC_SET_CLOSE_MINUTES_() -> String{
    return ccLocalizeString(string: "_CC_SET_CLOSE_MINUTES_", "");
}

public func _CC_HINT_KEEP_RUNNING_() -> String{
    return ccLocalizeString(string: "_CC_HINT_KEEP_RUNNING_", "");
}
public func _CC_HINT_HEADPHONE_() -> String{
    return ccLocalizeString(string: "_CC_HINT_HEADPHONE_", "");
}
public func _CC_HINT_FOCUS_PLAY_REMAIN_() -> String{
    return ccLocalizeString(string: "_CC_HINT_FOCUS_PLAY_REMAIN_", "");
}
public func _CC_HINT_PLAY_WITH_SPEAKER_() -> String{
    return ccLocalizeString(string: "_CC_HINT_PLAY_WITH_SPEAKER_", "");
}
public func _CC_HINT_WELCOME_USE_RAINVILLE_() -> String{
    return ccLocalizeString(string: "_CC_HINT_WELCOME_USE_RAINVILLE_", "");
}
public func _CC_HINT_USE_RAINVILLE_SUMMARY_() -> String{
    return ccLocalizeString(string: "_CC_HINT_USE_RAINVILLE_SUMMARY_", "");
}
public func _CC_HINT_PANEL_INTRO_() -> String{
    return ccLocalizeString(string: "_CC_HINT_PANEL_INTRO_", "");
}
public func _CC_HINT_PANEL_INTRO_SUMMARY_() -> String{
    return ccLocalizeString(string: "_CC_HINT_PANEL_INTRO_SUMMARY_", "");
}

public func _CC_VERSION_() -> String{
    return ccLocalizeString(string: "_CC_VERSION_", "");
}

public func _CC_ARRAY_ITEM_() -> Array<Any>{
    let stringFileName : String = (_CC_LANGUAGE_() == "简体中文") ? "ArrayItem_CH" : "ArrayItem_EN" ;
    let stringFilePath : String = Bundle.main.path(forResource: stringFileName, ofType: "plist")!;
    return NSArray.init(contentsOfFile: stringFilePath) as! Array<Any>;
}
