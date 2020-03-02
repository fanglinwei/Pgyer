//
//  MainNoticeController.swift
//  PgyerUpdate
//
//  Created by 方林威 on 2019/11/1.
//  Copyright © 2019 方林威. All rights reserved.
//

import Cocoa

protocol MainWechatControllerDelegate: NSObjectProtocol {
    func done(robots: [Robot])
}

class MainNoticeController: NSViewController {
    
    weak var delegate: MainWechatControllerDelegate?

    @IBOutlet weak var feishuBox: NSButton!
    @IBOutlet weak var wxBox: NSButton!
    
    
    private var bundleId: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        feishuBox.state = .on
        wxBox.state = .off
    }
    
    @IBAction func doneAction(_ sender: Any) {
        var robots: [Robot] = []
        
        if feishuBox.state == .on {
            robots.append(.feishu(Robot.Feishu()))
        }
        
        if wxBox.state == .on {
            robots.append(.wechat(Robot.Wechat()))
        }

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
