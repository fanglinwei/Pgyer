//
//  MainWechatController.swift
//  PgyerUpdate
//
//  Created by 方林威 on 2019/11/1.
//  Copyright © 2019 方林威. All rights reserved.
//

import Cocoa

class MainWechatController: NSViewController {

    @IBOutlet weak var keyTextField: NSTextField!
    @IBOutlet weak var qrCodeBox: NSButton!
    
    private var bundleId: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        let robot = Wechat.robots.first { $0.bundleId == bundleId}
        keyTextField.stringValue = robot?.key ?? ""
        
        if let isOn = robot?.isQR, isOn {
            qrCodeBox.state = .on
        } else {
            qrCodeBox.state = .off
        }
    }
    
    @IBAction func doneAction(_ sender: Any) {
        let key = keyTextField.stringValue
        let isOn = qrCodeBox.state == .on
        let robot = Wechat.Robot.init(bundleId: bundleId, key: key, isQR: isOn)
        Wechat.addRobot(with: robot)
        
        dismiss(self)
    }
    
    static func instance(_ bundleId: String) -> Self {
        let controller = instance()
        controller.bundleId = bundleId
        return controller
    }
    
    private static func instance() -> Self {
        return StoryBoard.main.instance()
    }
}
