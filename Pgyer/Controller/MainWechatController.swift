//
//  MainWechatController.swift
//  PgyerUpdate
//
//  Created by 方林威 on 2019/11/1.
//  Copyright © 2019 方林威. All rights reserved.
//

import Cocoa

protocol MainWechatControllerDelegate: NSObjectProtocol {
    func done(robots: [Wechat.Robot])
}

class MainWechatController: NSViewController {
    
    weak var delegate: MainWechatControllerDelegate?

    @IBOutlet weak var box: NSButton!
    @IBOutlet weak var qrCodeBox: NSButton!
    
    private var bundleId: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        box.state = .on
    }
    
    @IBAction func doneAction(_ sender: Any) {
        var robots: [Wechat.Robot] = []
        
        let isQR = qrCodeBox.state == .on
        let robot = Wechat.Robot(key: "0a3fdd95-47cd-4dd2-9790-bc2f7efd2cb9", isQR: isQR)
        robots.append(robot)
        
        delegate?.done(robots: robots)
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
