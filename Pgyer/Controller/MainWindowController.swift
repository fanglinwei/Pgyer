//
//  MainWindowController.swift
//  tinypng4mac
//
//  Created by kyle on 16/7/5.
//  Copyright © 2016年 kyleduo. All rights reserved.
//

import Cocoa

class MainWindowController: NSWindowController {
	
	override func windowDidLoad() {
		super.windowDidLoad()
        contentViewController = MainViewController.instance()
	}
}
