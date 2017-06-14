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

typealias CCSelectClosure = (String , Int) -> Void ;

enum CCAudioControl : Int {
    case next = 0 , previous
}

class CCMainScrollCell: UITableViewCell, CCCountDownDelegate {
    
    var delegate : CCCellTimerDelegate?;
    
    private lazy var scrollViewBottom: UIScrollView = {
        return CCMainHandler.ccCreateMainBottomScrollView()
    }()
    
    private lazy var tableView : UITableView = {
        return CCMainHandler.ccCreateMainTableView();
    }();
    
    private lazy var viewInfo : CCAuthorInfoView? = {
        return CCAuthorInfoView.initFromNib();
    }();
    private lazy var viewCountDown : CCCountDownView? = {
        return CCCountDownView.initFromNib();
    }();
    
    private lazy var arrayItem: Array = {
        return  _CC_ARRAY_ITEM_();
    }()
    private var closure : ((String , Int) -> Void)?;
    private var integerSelectedIndex : Int = 0;
    private var lightTableViewDelegate : CCMainLighterDelegate?;
    private var lightTableViewDataSource : CCMainLighterDataSource?;
    
    func ccConfigureCellWithHandler(_ closure : @escaping CCSelectClosure) {
        self.ccLayoutSubViews();
        
        
        self.lightTableViewDataSource = CCMainLighterDataSource.init(withReloadClosure: nil);
        if let dataSourceT = self.lightTableViewDataSource {
            self.tableView.dataSource = dataSourceT;
        }
        
        self.lightTableViewDelegate = CCMainLighterDelegate.init(withSelectedClosure: { [unowned self] (intSelectedIndex : Int) in
            self.integerSelectedIndex = intSelectedIndex;
            if let closureT = self.closure {
                closureT(self.arrayItem[intSelectedIndex] as! String , intSelectedIndex);
            };
        });
        
        if let delegateT = self.lightTableViewDelegate {
            self.tableView.delegate = delegateT;
        }
        
        self.closure = closure;
    }
    
    func ccSetPlayingAudio(_ sender : CCAudioControl) {
        switch sender {
        case .next:
            self.integerSelectedIndex += 1 ;
            if self.integerSelectedIndex > self.arrayItem.count - 1 {
                self.integerSelectedIndex -= 1;
            }
        case .previous:
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
    
//MARK: - Private
    private func ccLayoutSubViews() {
        self.backgroundColor = UIColor.clear;
        self.contentView.backgroundColor = UIColor.clear;
        
        self.contentView.addSubview(self.scrollViewBottom);
        self.scrollViewBottom.addSubview(self.tableView);
        self.scrollViewBottom.addSubview(self.viewInfo!);
        self.scrollViewBottom.addSubview(self.viewCountDown!);
    }
    
//MARK: - CCCountDownDelegate
    func ccCountDownWithTime(int: Int) {
        CCLog("_CC_COUNT_DOWN_SECONDS_\(int)_");
        self.delegate?.ccCellTimerWithSeconds(int);
    }

}
