//
//  CCAudioPreset.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 31/05/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import Foundation

func ccDefaultAudioSet () -> Dictionary<String, Any> {
    let _CC_FAIRY_RAIN_ : [Float] = [0.0,0.0,0.0,0.0,0.1,0.2,0.3,0.4,0.5,0.6];
    
    let _CC_BEDROOM_ : [Float] = [0.0,0.0,0.0,0.0,0.1,0.2,0.3,0.2,0.1,0.0];
    
    let _CC_UNDER_THE_PORCH_ : [Float] = [0.0,0.3,0.25,0.25,0.3,0.25,0.2,0.15,0.1,0.0];
    
    let _CC_DISTANT_STORM_ : [Float] = [0.7,0.6,0.5,0.4,0.3,0.2,0.2,0.3,0.2,0.1];
    
    let _CC_GETTING_WET_ : [Float] = [0.7,0.5,0.2,0.35,0.55,0.35,0.3,0.5,0.2,0.2];
    
    let _CC_ONLY_RUMBLE_ : [Float] = [0.7,0.5,0.15,0.15,0.15,0.15,0.1,0.1,0.0,0.0];
    
    
    let _CC_UNDER_THE_LEAVES_ : [Float] = [0.3,0.3,0.0,0.0,0.0,0.3,0.0,0.0,0.1,0.2];
    
    let _CC_DARK_RAIN_ : [Float] = [0.0,0.5,0.4,0.3,0.2,0.0,0.0,0.1,0.1,0.0];
    
    let _CC_JUNGLE_LODGE_ : [Float] = [0.7,0.0,0.2,0.0,0.25,0.0,0.25,0.0,0.2,0.0];
    
    let _CC_BROWN_NOISE_ : [Float] = [0.65,0.6,0.55,0.5,0.45,0.4,0.35,0.3,0.25,0.2];
    
    let _CC_PINK_NOISE_ : [Float] = [0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3,0.3];
    
    let _CC_WHITE_NOISE_ : [Float] = [0.2,0.25,0.3,0.35,0.4,0.45,0.5,0.55,0.6,0.65];
    
    let _CC_GREY_NOISE_ : [Float] = [0.5,0.45,0.4,0.3,0.3,0.3,0.25,0.25,0.3,0.35];
    
    
    let _CC_60_HZ_ : [Float] = [0.4,0.5,0.4,0.0,0.0,0.0,0.0,0.0,0.0,0.0];
    
    let _CC_125_HZ_ : [Float] = [0.0,0.4,0.5,0.4,0.0,0.0,0.0,0.0,0.0,0.0];
    
    let _CC_250_HZ_ : [Float] = [0.0,0.0,0.4,0.5,0.4,0.0,0.0,0.0,0.0,0.0];
    
    let _CC_500_HZ_ : [Float] = [0.0,0.0,0.0,0.4,0.5,0.4,0.0,0.0,0.0,0.0];
    
    let _CC_1K_HZ_ : [Float] = [0.0,0.0,0.0,0.0,0.4,0.5,0.4,0.0,0.0,0.0];
    
    let _CC_2K_HZ_ : [Float] = [0.0,0.0,0.0,0.0,0.0,0.4,0.5,0.4,0.0,0.0];
    
    let _CC_4K_HZ_ : [Float] = [0.0,0.0,0.0,0.0,0.0,0.0,0.4,0.5,0.4,0.0];
    
    let _CC_8K_HZ_ : [Float] = [0.0,0.0,0.0,0.0,0.0,0.0,0.0,0.4,0.5,0.6];
    
    let _CC_DEFAULT_PRESET_ : [Float] = _CC_PINK_NOISE_;
    
    let array : [String] = _CC_ARRAY_ITEM_() as! [String];
    let dictionary : Dictionary = Dictionary.init(dictionaryLiteral: (array[0] , _CC_DEFAULT_PRESET_),
        (array[1] , _CC_FAIRY_RAIN_),
        (array[2] , _CC_BEDROOM_),
        (array[3] , _CC_UNDER_THE_PORCH_),
        (array[4] , _CC_DISTANT_STORM_),
        (array[5] , _CC_GETTING_WET_),
        (array[6] , _CC_ONLY_RUMBLE_),
        (array[7] , _CC_UNDER_THE_LEAVES_),
        (array[8] , _CC_DARK_RAIN_),
        (array[9] , _CC_JUNGLE_LODGE_),
        (array[10] , _CC_BROWN_NOISE_),
        (array[11] , _CC_PINK_NOISE_),
        (array[12] , _CC_WHITE_NOISE_),
        (array[13] , _CC_GREY_NOISE_),
        (array[14] , _CC_60_HZ_),
        (array[15] , _CC_125_HZ_),
        (array[16] , _CC_250_HZ_),
        (array[17] , _CC_500_HZ_),
        (array[18] , _CC_1K_HZ_),
        (array[19] , _CC_2K_HZ_),
        (array[20] , _CC_4K_HZ_),
        (array[21] , _CC_8K_HZ_));
    return dictionary;
}

/// url object
func ccAudioFilePath () -> [URL] {
    var array : [URL] = [];
    for i in 0...9 {
        let stringFilePath : String = Bundle.main.path(forResource: "_\(i)", ofType: "wav")!;
        if let url = ccURL(stringFilePath, false) {
            array.append(url);
        }
    }
    return array ;
}
