//
//  CCMainViewController.swift
//  Rainville-Swift
//
//  Created by 冯明庆 on 31/05/2017.
//  Copyright © 2017 冯明庆. All rights reserved.
//

import UIKit

class CCMainViewController: CCBaseViewController , UITableViewDelegate , UITableViewDataSource , CCPlayActionDelegate , CCCellTimerDelegate {

    @IBOutlet private weak var labelPoem: UILabel!
    
    private lazy var tableView: UITableView = {
        return CCMainHandler.ccCreateContentTableView();
    }()
    private lazy var cell: CCMainScrollCell = {
        return CCMainScrollCell.init();
    }()
    private lazy var headerView: CCMainHeaderView? = {
        return CCMainHeaderView.initFromNib();
    }()
    private lazy var handler: CCAudioHandler = {
        return CCAudioHandler.sharedInstance;
    }()
    private let dictionaryTheme: Dictionary! = ccDefaultAudioSet();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.ccDefaultSettings();
        self.ccInitViewSettings();
    }
    
//MARK: - Private
    private func ccDefaultSettings() {
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(ccNotificationRemoteControl(_:)),
                                               name: NSNotification.Name(rawValue: _CC_APP_DID_RECEIVE_REMOTE_NOTIFICATION_),
                                               object: nil);
    }
    private func ccInitViewSettings() {
        let _ = self.labelPoem.ccMusket(12.0, _CC_RAIN_POEM_());
        self.view.addSubview(self.tableView);
        
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        
        self.headerView?.delegate = self;
        self.tableView.tableHeaderView = self.headerView;
        
        self.cell.delegate = self;
        self.cell.ccConfigureCellWithHandler { [unowned self] (stringKey : String, intSelectedIndex : Int) in
            self.ccClickedAction(intSelectedIndex, withKey: stringKey);
            self.cell.ccSetTimer(true);
        }
    }
    @objc private func ccNotificationRemoteControl(_ sender : Notification) {
        let eventSubtype : UIEventSubtype? = sender.userInfo?["key"] as? UIEventSubtype;
        guard (eventSubtype != nil) else {
            return;
        }
        if let eventSubtypeT = eventSubtype {
            if eventSubtypeT.rawValue < 0 {
                return;
            }
            switch eventSubtypeT {
            case .remoteControlPause:
                self.handler.ccPausePlayingWithCompleteHandler({ 
                    CCLog("_CC_PAUSE_SUCCEED_");
                }, .pause);
                self.headerView?.ccSetButtonStatus(bool: false);
            case .remoteControlPlay:
                self.handler.ccPausePlayingWithCompleteHandler({
                    CCLog("_CC_PLAY_SUCCEED_");
                }, .play);
                self.headerView?.ccSetButtonStatus(bool: true);
            case .remoteControlNextTrack:
                self.cell.ccSetPlayingAudio(.next);
            case .remoteControlPreviousTrack:
                self.cell.ccSetPlayingAudio(.previous);
            default:
                return;
            }
        }
    }
    
//MARK: - UITableViewDataSource , UITableViewDelegate
    internal func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1;
    }
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return self.cell;
    }
    internal func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return CGFloat(ccScreenHeight() * 0.3);
    }
    
//MARK: - CCPlayActionDelegate
    internal func ccHeaderButtonActionWithPlayOrPause(bool: Bool) {
        self.handler.ccPausePlayingWithCompleteHandler({
                CCLog("_CC_PAUSE/PLAY_SUCCEED_");
            }, (bool ? .play : .pause));
        self.cell.ccSetTimer(bool);
        if !bool {
            self.ccCellTimerWithSeconds(0);
        }
    }
    
//MARK: - CCCellTimerDelegate
    internal func ccCellTimerWithSeconds(_ integerSeconds: Int) {
        self.handler.ccSetAutoStopWithSeconds(integerSeconds) { [unowned self] (isSucceed : Bool, item : Any?) in
            if let itemT = item {
                self.headerView?.labelCountDown.text = itemT as? String;
            }
            self.headerView?.labelCountDown.isHidden = isSucceed;
        }
    }
    
    private func ccClickedAction(_ intIndex : Int , withKey stringKey : String) {
        self.handler.ccSetAudioPlayerWithVolumeArray(self.dictionaryTheme[stringKey] as? Array<Float>) { [unowned self] in
            self.handler.ccSetInstantPlayingInfo(stringKey);
        }
        self.headerView?.ccSetButtonStatus(bool: true);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
