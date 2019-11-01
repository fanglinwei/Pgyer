//
//  MainKeyController.swift
//  PgyerUpdate
//
//  Created by 方林威 on 2019/10/31.
//  Copyright © 2019 方林威. All rights reserved.
//

import Cocoa

class MainKeyController: NSViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    static func instance() -> Self {
        return StoryBoard.main.instance()
    }
}
