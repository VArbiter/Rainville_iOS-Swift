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
    
    private var array : [Int]!;
    
    class func initFromNib() -> CCCountDownView? {
        let viewCountDown : CCCountDownView? = Bundle.main.loadNibNamed("CCCountDownView", owner: nil, options: nil)?.first as? CCCountDownView;
        if let viewCountDownT = viewCountDown {
            viewCountDownT.frame = CGRect(x: ccScreenWidth(), y: 0, width: ccScreenWidth(), height: ccScreenHeight() * 0.3);
            viewCountDownT.ccDefaultSettings();
            return viewCountDownT;
        }
        return nil;
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
        let closure = {(labelC : UILabel) -> UILabel in
            labelC.font = UIFont.ccMusketFontWithSize(11.0);
            labelC.textAlignment = NSTextAlignment.center;
            labelC.backgroundColor = UIColor.clear;
            labelC.textColor = ccHexColor(0xFEFEFE);
            labelC.text = self.pickerView(pickerView, titleForRow: row, forComponent: component);
            return labelC;
        };
        
        pickerView.ccCyanSeperateLine();
        let label : UILabel? = view as? UILabel;
        if let labelT = label {
            return closure(labelT);
        } else {
            return closure(UILabel.init());
        }
    }
    internal func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.delegate?.ccCountDownWithTime(int: self.array[row] * 60)
    }
  
}
