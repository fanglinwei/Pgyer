//
//  MainPrepareController.swift
//  PgyerUpdate
//
//  Created by 方林威 on 2019/11/1.
//  Copyright © 2019 方林威. All rights reserved.
//

import Cocoa
import Kingfisher

class MainPrepareController: ViewController<PrepareView> {
    
    var name: String = ""
    var bundleId: String = ""
    var version: String = ""
    var date: Date?
    var path: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadData()
        
        
    }
    
    private func setup() {
        Wechat.addRobot(default: bundleId)
        container.nameLabel.stringValue = name
        container.identiflerLabel.stringValue = bundleId
        container.versionLabel.stringValue = version
        title = name
    }
    
    @IBAction func wechatAction(_ sender: Any) {
        let controller =  MainWechatController.instance(bundleId)
        presentAsModalWindow(controller)
    }
    
    @IBAction func uploadAction(_ sender: Any) {
        guard let path = path else { return }
        // 开始上传
        let desc = container.updateDescTextView.string
        let upload = Pgyer.Upload(description: desc, file: path)
        let options: [API.Option] = [.progress({ [weak self] progress in
            self?.container.progressView.doubleValue = progress
        })]
        
        API.pgyer.load(.upload(upload), options: options) {
            [weak self] (result: API.Result<Build>) in
            guard let self = self else { return }
            guard let value = result.value else { return }
            self.sendWetch(value)
            
            // alert
            let alert = NSAlert()
            alert.messageText = "上传成功"
            alert.runModal()
        }
    }
    
    static func instance(_ name: String,
                         bundleId: String,
                         version: String,
                         bundleVersion: String,
                         date: Date?,
                         path: URL) -> Self {
        let controller = instance()
        controller.name = name
        controller.bundleId = bundleId
        controller.version = "\(version)(\(bundleVersion))"
        controller.date = date
        controller.path = path
        return controller
    }
    
    static func instance() -> Self {
        return StoryBoard.main.instance()
    }
}

extension MainPrepareController {
    
    private func loadData() {
        API.pgyer.load(.uploadPrepare(type: "ios", bundleId: bundleId)) {
            [weak self](result: API.Result<Prepare>) in
            guard let self = self else { return }
            guard let value = result.value else { return }
            
            self.container.downlinkLabel.stringValue = "http://www.pgyer.com/" + value.shortcutUrl
            self.container.updateDescTextView.string = value.parentApp.a_update_description
            let icon = "https://appicon.pgyer.com/image/view/app_icons/" + value.parentApp.a_icon
            self.container.imageView.kf.setImage(with: icon)
        }
    }
    
    // 关联企业微信
    private func sendWetch(_ build: Build) {
        guard let robot = Wechat.robots.first(where: { $0.bundleId == bundleId }) else {
            return
        }
        // 发信息
        let url = "http://www.pgyer.com/" + build.buildShortcutUrl
        let content = container.updateDescTextView.string + "\n安装地址: \(url)"
        API.wechat.load(.sendText(key: robot.key, content: content, at: robot.mobile))
    
        // 发图片
        if robot.isQR {
            KingfisherManager.shared.retrieveImage(with: build.buildQRCodeURL) { (result) in
                guard let url = result.value?.source.url,
                    let data = try? Data(contentsOf: url) else {
                        return
                }
                let base64 = data.base64EncodedString()
                API.wechat.load(.sendImage(key: robot.key, content: base64, md5: data.md5))
            }
        }
    }
}


extension MainPrepareController {
    
    struct Prepare: Codable {
        let shortcutUrl: String
        let parentApp: App
        
        struct App: Codable {
            let a_update_description: String
            let a_icon: String
        }
    }
    
    struct Build: Codable {
        let buildShortcutUrl: String
        let buildQRCodeURL: String
        let buildUpdated: String
        let buildUpdateDescription: String
    }
}

