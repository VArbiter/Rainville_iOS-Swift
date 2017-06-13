//
//  CCMainLighterTableView.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 05/06/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import UIKit


class CCMainLighterDataSource : NSObject , UITableViewDataSource {
    
    private lazy var arrayData : Array = {
        return _CC_ARRAY_ITEM_();
    }()
    
    convenience init(withReloadClosure closure : (() -> Void)?) {
        if let closureNew = closure {
            closureNew();
        }
        self.init();
    }
    
//MARK: - UITableViewDataSource
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.arrayData.count;
    }
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell : UITableViewCell? = tableView.dequeueReusableCell(withIdentifier: "_CC_CELL_ID_");
        if let cellNew = cell {
            return cellNew;
        } else {
            cell = UITableViewCell.init(style: UITableViewCellStyle.default, reuseIdentifier: "_CC_CELL_ID_");
            cell?.textLabel?.textColor = ccHexColor(0xFEFEFE);
            cell?.backgroundColor = UIColor.clear;
            cell?.selectedBackgroundView = UIView.init(frame: (cell?.bounds)!);
            cell?.selectedBackgroundView?.backgroundColor = ccHexColor(0x22A1A2);
            cell?.textLabel?.highlightedTextColor = ccHexColor(0x333333);
            let _ = cell?.textLabel?.ccMusket(15.0, self.arrayData[indexPath.row] as! String);
            return cell!;
        }
    }
}

//MARK: - ----------------------------------------------------------------------

class CCMainLighterDelegate: NSObject , UITableViewDelegate {
    
    private var closure : ((Int) -> Void)? = nil;
    private var integerSelectedIndex : Int = 0 ;
    
    convenience init(withSelectedClosure closure : @escaping (Int) -> Void) {
        self.init();
        self.closure = closure;
        self.integerSelectedIndex = -1;
    }
    
//MARK: - UITableViewDelegate
    
    internal func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.integerSelectedIndex == indexPath.row {
            self.integerSelectedIndex = indexPath.row;
            weak var pSelf = self ;
            CC_Safe_UI_Closure(self.closure, { 
                pSelf?.closure!((pSelf?.integerSelectedIndex)!);
            });
        }
    }
    
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(ccScreenHeight() * 0.3 / 6.0) ;
    }
    
    internal func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutMargins = UIEdgeInsets.zero;
        cell.separatorInset = UIEdgeInsets.zero;
    }
}
