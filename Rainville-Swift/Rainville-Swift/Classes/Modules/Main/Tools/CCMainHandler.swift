//
//  CCMainHandler.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 01/06/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import UIKit
import AVFoundation
import AudioToolbox

class CCMainHandler: NSObject {
    
    public class func ccIsHeadPhoneInsertWithHandler(_ closure : @escaping CCCommonClosure) -> Bool {
        var isHeadphoneInsert : Bool = false;
        if __IPHONE_OS_VERSION_MAX_ALLOWED > Int32(7.0) {
            let route : AVAudioSessionRouteDescription = AVAudioSession.sharedInstance().currentRoute;
            for (_ , item) in route.outputs.enumerated() {
                if item.isKind(of: AVAudioSessionRouteDescription.self) {
                    if item.portType.compare(AVAudioSessionPortHeadphones) == ComparisonResult.orderedSame {
                        isHeadphoneInsert = true;
                        break;
                    }
                }
            }
        } else  {
//            let propertySize : UInt32 = UInt32(MemoryLayout<CFString>.size);
        }
        
        CC_Safe_Closure(closure) {
            closure(isHeadphoneInsert , ccNULL);
        }
        
        return isHeadphoneInsert;
    }
    
    public class func ccIsMuteEnabledWithHandler(_ closure : @escaping CCCommonClosure) -> Bool {
        var isMuteEnabled : Bool = false;
        if __IPHONE_OS_VERSION_MAX_ALLOWED > Int32(7.0) {
//TODO: 检测 7.0 以上静音 .
            isMuteEnabled = false;
        } else {
            
        }
        
        CC_Safe_Closure(closure) {
            closure(isMuteEnabled , ccNULL);
        }
        return isMuteEnabled;
    }
    
    public class func ccCreateMainBottomScrollViewWithView() -> UIScrollView {
        let scrollView : UIScrollView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: ccScreenWidth(), height: ccScreenHeight() * 0.3));
        scrollView.showsVerticalScrollIndicator = false;
        scrollView.showsHorizontalScrollIndicator = false;
        scrollView.bounces = false;
        scrollView.bouncesZoom = false;
        scrollView.isPagingEnabled = true;
        scrollView.backgroundColor = UIColor.clear;
        scrollView.contentSize = CGSize(width: ccScreenWidth() * 3.0, height: scrollView.height);
        
        return scrollView;
    }
    
    public class func ccCreateContentTableView() -> UITableView {
        let tableView : UITableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: ccScreenWidth(), height: ccScreenHeight()), style: UITableViewStyle.plain);
        tableView.separatorStyle = UITableViewCellSeparatorStyle.none ;
        tableView.showsHorizontalScrollIndicator = false;
        tableView.showsVerticalScrollIndicator = false;
        tableView.alwaysBounceVertical = true;
        tableView.backgroundColor = UIColor.clear;
        
        return tableView;
    }
    
    public class func ccCreateMainTableViewWithScrollView(_ scrollView : UIScrollView) -> UITableView {
        let tableView : UITableView = UITableView.init(frame: CGRect(x: 0, y: 0, width: ccScreenWidth(), height: scrollView.height), style: UITableViewStyle.plain);
        tableView.backgroundColor = UIColor.clear;
        tableView.separatorColor = ccHexColor(0x434D5B);
        tableView.showsHorizontalScrollIndicator = false;
        tableView.bounces = false;
        tableView.indicatorStyle = UIScrollViewIndicatorStyle.white;
        tableView.separatorInset = UIEdgeInsets.zero;
        tableView.layoutMargins = UIEdgeInsets.zero;
        
        return tableView;
    }
    
}
