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
    
    public var delegate : CCCellTimerDelegate?;
    
    private var scrollViewBottom : UIScrollView! ;
    private var tableView : UITableView! ;
    private var viewInfo : CCAuthorInfoView! ;
    private var viewCountDown : CCCountDownView! ;
    
    private lazy var arrayItem: Array = {
        return  _CC_ARRAY_ITEM_();
    }()
    private let closure : ((String , Int) -> Void)?;
    private var integerSelectedIndex : Int;
    private let lightTableViewDelegate : CCMainLighterDelegate;
    private let lightTableViewDataSource : CCMainLighterDataSource;
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier);
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(_ frame : CGRect) {
        self.init(frame: frame);
        self.frame = frame;
        self.backgroundColor = UIColor.clear;
        self.integerSelectedIndex = 0 ;
    }
    
    override func layoutSubviews() {
        
        self.scrollViewBottom = CCMainHandler.ccCreateMainBottomScrollViewWithView();
        self.contentView.addSubview(self.scrollViewBottom);
        
        self.viewInfo = CCAuthorInfoView.initFromNib();
        self.scrollViewBottom.addSubview(self.viewInfo);
        
        self.viewCountDown = CCCountDownView.initFromNib();
        self.viewCountDown.delegate = self;
        self.scrollViewBottom.addSubview(self.viewCountDown);
        
        self.tableView = CCMainHandler.ccCreateMainTableViewWithScrollView(self.scrollViewBottom);
        self.scrollViewBottom.addSubview(self.tableView);
        
    }
    
    public func ccConfigureCellWithHandler(_ block : @escaping CCSelectBlock) -> Void {
        
    }
    
    public func ccSetPlayingAudio(_ control : CCAudioControl) -> Void {
        
    }
    
    public func ccSetTimer(_ isEnable : Bool) -> Void {
        
    }
    
//MARK: - CCCountDownDelegate
    func ccCountDownWithTime(int: Int) {
        CCLog("_CC_COUNT_DOWN_SECONDS_\(int)_");
        self.delegate?.ccCellTimerWithSeconds(int);
    }

}
