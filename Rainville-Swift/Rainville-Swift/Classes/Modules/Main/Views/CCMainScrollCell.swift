//
//  CCMainScrollCell.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 05/06/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import UIKit

protocol CCCellTimerDelegate {
    func ccCellTimerWithSeconds(_ integerSeconds : Int) -> Void ;
}

typealias CCSelectBlock = (String , Int) -> Void ;

enum CCAudioControl : Int {
    case CCAudioControlNext = 0
    case CCAudioControlPrevious
}

class CCMainScrollCell: UITableViewCell, CCCountDownDelegate {
    
    var delegate : CCCellTimerDelegate?;
    
    private lazy var scrollViewBottom: UIScrollView = {
        return CCMainHandler.ccCreateMainBottomScrollViewWithView()
    }()
    
    private var tableView : UITableView! ;
    
    private var viewInfo : CCAuthorInfoView? ;
    private var viewCountDown : CCCountDownView? ;
    
    private lazy var arrayItem: Array = {
        return  _CC_ARRAY_ITEM_();
    }()
    private var closure : ((String , Int) -> Void)?;
    private var integerSelectedIndex : Int = 0;
    private var lightTableViewDelegate : CCMainLighterDelegate?;
    private var lightTableViewDataSource : CCMainLighterDataSource?;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(_ frame : CGRect) {
        self.init();
        self.frame = frame;
        self.backgroundColor = UIColor.clear;
        self.setNeedsLayout();
        self.layoutIfNeeded();
    }
    
    
    override func layoutIfNeeded() {
        super.layoutIfNeeded();
        
        self.scrollViewBottom = CCMainHandler.ccCreateMainBottomScrollViewWithView();
        self.contentView.addSubview(self.scrollViewBottom);
        
        self.tableView = CCMainHandler.ccCreateMainTableViewWithScrollView(self.scrollViewBottom);
        self.scrollViewBottom.addSubview(self.tableView!);
        
        self.viewInfo = CCAuthorInfoView.initFromNib();
        self.scrollViewBottom.addSubview(self.viewInfo!);
        
        self.viewCountDown = CCCountDownView.initFromNib();
        self.viewCountDown?.delegate = self;
        self.scrollViewBottom.addSubview(self.viewCountDown!);
    }
    
    func ccConfigureCellWithHandler(_ block : @escaping CCSelectBlock) {
        self.contentView.backgroundColor = UIColor.clear;
        
        self.lightTableViewDataSource = CCMainLighterDataSource.init(withReloadClosure: nil);
        if let dataSourceT = self.lightTableViewDataSource {
            self.tableView.dataSource = dataSourceT;
        }
        
        self.lightTableViewDelegate = CCMainLighterDelegate.init(withSelectedClosure: { [unowned self] (intSelectedIndex : Int) in
            self.integerSelectedIndex = intSelectedIndex;
            if let closure = self.closure {
                closure(self.arrayItem[intSelectedIndex] as! String , intSelectedIndex);
            };
        });
        if let delegateT = self.lightTableViewDelegate {
            self.tableView.delegate = delegateT;
        }
    }
    
    func ccSetPlayingAudio(_ sender : CCAudioControl) {
        switch sender {
        case .CCAudioControlNext:
            self.integerSelectedIndex += 1 ;
            if self.integerSelectedIndex > self.arrayItem.count - 1 {
                self.integerSelectedIndex -= 1;
            }
        case .CCAudioControlPrevious:
            self.integerSelectedIndex -= 1;
            if self.integerSelectedIndex < 0 {
                self.integerSelectedIndex += 1;
            }
        default: break;
            
        }
        
        if let closure = self.closure {
            closure(self.arrayItem[self.integerSelectedIndex] as! String , self.integerSelectedIndex);
        }
    }
    
    func ccSetTimer(_ isEnable : Bool) {
        self.viewCountDown?.ccEnableCountingDown(bool: isEnable);
        if !isEnable {
            self.viewCountDown?.ccCancelAndResetCountingDown();
        }
    }
    
//MARK: - CCCountDownDelegate
    func ccCountDownWithTime(int: Int) {
        CCLog("_CC_COUNT_DOWN_SECONDS_\(int)_");
        self.delegate?.ccCellTimerWithSeconds(int);
    }

}
