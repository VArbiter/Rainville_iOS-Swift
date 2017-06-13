//
//  CCLocalizedHelper.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 31/05/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import Foundation

func _CC_LANGUAGE_() -> String {
    return ccLocalizeString("_CC_LANGUAGE_", "");
}
func _CC_APP_NAME_() -> String {
    return ccLocalizeString("_CC_APP_NAME_", "");
}
func _CC_APP_DESP_() -> String {
    return ccLocalizeString("_CC_APP_DESP_", "");
}

func _CC_RAIN_POEM_() -> String {
    return ccLocalizeString("_CC_RAIN_POEM_", "");
}

func _CC_PLAY_() -> String{
    return ccLocalizeString("_CC_PLAY_", "");
}
func _CC_STOP_() -> String{
    return ccLocalizeString("_CC_STOP_", "");
}
func _CC_CONFIRM_() -> String{
    return ccLocalizeString("_CC_CONFIRM_", "");
}
func _CC_CANCEL_() -> String{
    return ccLocalizeString("_CC_CANCEL_", "");
}
func _CC_SET_CLOSE_TIMER_() -> String{
    return ccLocalizeString("_CC_SET_CLOSE_TIMER_", "");
}
func _CC_SET_CLOSE_MINUTES_() -> String{
    return ccLocalizeString("_CC_SET_CLOSE_MINUTES_", "");
}

func _CC_HINT_KEEP_RUNNING_() -> String{
    return ccLocalizeString("_CC_HINT_KEEP_RUNNING_", "");
}
func _CC_HINT_HEADPHONE_() -> String{
    return ccLocalizeString("_CC_HINT_HEADPHONE_", "");
}
func _CC_HINT_FOCUS_PLAY_REMAIN_() -> String{
    return ccLocalizeString("_CC_HINT_FOCUS_PLAY_REMAIN_", "");
}
func _CC_HINT_PLAY_WITH_SPEAKER_() -> String{
    return ccLocalizeString("_CC_HINT_PLAY_WITH_SPEAKER_", "");
}
func _CC_HINT_WELCOME_USE_RAINVILLE_() -> String{
    return ccLocalizeString("_CC_HINT_WELCOME_USE_RAINVILLE_", "");
}
func _CC_HINT_USE_RAINVILLE_SUMMARY_() -> String{
    return ccLocalizeString("_CC_HINT_USE_RAINVILLE_SUMMARY_", "");
}
func _CC_HINT_PANEL_INTRO_() -> String{
    return ccLocalizeString("_CC_HINT_PANEL_INTRO_", "");
}
func _CC_HINT_PANEL_INTRO_SUMMARY_() -> String{
    return ccLocalizeString("_CC_HINT_PANEL_INTRO_SUMMARY_", "");
}

func _CC_VERSION_() -> String{
    return ccLocalizeString("_CC_VERSION_", "");
}

func _CC_ARRAY_ITEM_() -> Array<Any>{
    let stringFileName : String = (_CC_LANGUAGE_() == "简体中文") ? "ArrayItem_CH" : "ArrayItem_EN" ;
    let stringFilePath : String = Bundle.main.path(forResource: stringFileName, ofType: "plist")!;
    return NSArray.init(contentsOfFile: stringFilePath) as! Array<Any>;
}
