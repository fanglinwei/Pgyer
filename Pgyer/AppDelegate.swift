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
    
    static var shared: AppDelegate {
        return NSApplication.shared.delegate as! AppDelegate
    }
    
    private var popover = NSPopover()
    private lazy var windowController = MainWindowController.instance()
    /// Status bar Pock icon
    private lazy var statusbar = NSStatusBar.system.statusItem(withLength: NSStatusItem.squareLength)
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        setupStatusbar()
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
        popover.contentViewController = MainViewController.instance()
    }
    
    static func hidenPopover() {
        shared.popover.close()
    }
    
    static func window(for controller: NSViewController) {
        shared.windowController.window?.orderOut(nil)
        shared.windowController.contentViewController = controller
        shared.windowController.window?.center()
        shared.windowController.window?.makeKey()
        shared.windowController.window?.orderFront(nil)
    }
}
