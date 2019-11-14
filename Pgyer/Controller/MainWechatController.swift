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

    @IBOutlet weak var proBox: NSButton!
    @IBOutlet weak var wordBox: NSButton!
    @IBOutlet weak var qrCodeBox: NSButton!
    
    private var bundleId: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        proBox.state = .off
        wordBox.state = .off
        switch bundleId {
        case "com.todoen.word":
            wordBox.state = .on
            
        case "com.todoen.ielts.main":
            proBox.state = .on
            
        default:
            break
        }
    }
    
    @IBAction func doneAction(_ sender: Any) {
        var robots: [Wechat.Robot] = []
        
        let isQR = qrCodeBox.state == .on
        
        if wordBox.state == .on {
            let robot = Wechat.Robot(key: Wechat.Robot.Mode.word.key, isQR: isQR)
            robots.append(robot)
        }
        
        if proBox.state == .on {
            let robot = Wechat.Robot(key: Wechat.Robot.Mode.pro.key, isQR: isQR)
            robots.append(robot)
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
