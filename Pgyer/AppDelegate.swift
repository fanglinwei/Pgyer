//
//  AppDelegate.swift
//  PgyerUpdate
//
//  Created by 方林威 on 2019/10/31.
//  Copyright © 2019 方林威. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

    fileprivate var popover = NSPopover()
    
    /// Status bar Pock icon
    private lazy var statusbar = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupStatusbar()
        popover.contentViewController = MainViewController.instance()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}


extension AppDelegate {
    
    @objc
    private func showPopover(_ sender: NSStatusBarButton) {
        if popover.isShown {
            popover.close()
        } else {
            popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.maxY)
        }
    }
    
    private func setupStatusbar() {
        guard let button = statusbar.button else {
            return
        }
        button.image = #imageLiteral(resourceName: "inner-icon")
        button.action = #selector(showPopover)
    }
}
