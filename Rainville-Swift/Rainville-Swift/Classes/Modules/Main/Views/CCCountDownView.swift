//
//  CCCountDownView.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 01/06/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import UIKit

protocol CCCountDownDelegate {
    func ccCountDownWithTime(int : Int) -> Void ;
}

class CCCountDownView: UIView , UIPickerViewDelegate , UIPickerViewDataSource {
    
    var delegate : CCCountDownDelegate? ; // nil 不调用 , 反之调用
    
    @IBOutlet private weak var pickerViewTime: UIPickerView!
    @IBOutlet private weak var labelLeft: UILabel!
    @IBOutlet private weak var labelRight: UILabel!
    
    private var array : Array<Int>!;
    
    class func initFromNib() -> CCCountDownView {
        let viewCountDown : CCCountDownView? = Bundle.main.loadNibNamed("CCCountDownView", owner: nil, options: nil)?.first as? CCCountDownView;
        if viewCountDown != nil {            
            viewCountDown?.frame = CGRect(x: ccScreenWidth(), y: 0, width: ccScreenWidth(), height: ccScreenHeight() * 0.3);
            viewCountDown?.ccDefaultSettings();
        }
        return viewCountDown!;
    }
    func ccEnableCountingDown(bool : Bool) {
        self.pickerViewTime.alpha = bool ? 1.0 : 0.8;
        self.pickerViewTime.isUserInteractionEnabled = bool;
    }
    func ccCancelAndResetCountingDown() {
        self.pickerViewTime.selectRow(0, inComponent: 0, animated: true);
    }
    
    private func ccDefaultSettings() {
        let _ = self.labelLeft.ccMusket(12.0, _CC_SET_CLOSE_TIMER_());
        let _ = self.labelRight.ccMusket(12.0, _CC_SET_CLOSE_MINUTES_());
        self.pickerViewTime.delegate = self;
        self.pickerViewTime.dataSource = self;
        self.array = Array<Int> ([0,5,10,15,20,25,30,35,40,45,50,55,60,90,120]);
    }
    
//MARK:- UIPickerViewDataSource
    internal func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1 ;
    }
    internal func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return self.array.count ;
    }
    
//MARK:- UIPickerViewDelegate
    internal func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return self.array[row] == 0 ? _CC_CANCEL_() : "\(self.array[row])" ;
    }
    internal func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return CGFloat(ccScreenHeight() * 0.3 * 0.35) ;
    }
    internal func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        var label : UILabel? ;
        if (view?.isKind(of: UILabel.self))! {
            label = view as? UILabel;
        }
        if label == nil {
            label = UILabel.init();
            label?.font = UIFont.ccMusketFontWithSize(11.0);
            label?.textAlignment = NSTextAlignment.center;
            label?.backgroundColor = UIColor.clear;
            label?.textColor = ccHexColor(0xFEFEFE);
        }
        label?.text = self .pickerView(pickerView, titleForRow: row, forComponent: component);
        pickerView.ccCyanSeperateLine();
        return label!;
    }
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.delegate?.ccCountDownWithTime(int: self.array[row] * 60)
    }
  
}
