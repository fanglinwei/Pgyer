//
//  PrepareView.swift
//  PgyerUpdate
//
//  Created by 方林威 on 2019/11/1.
//  Copyright © 2019 方林威. All rights reserved.
//

import Cocoa

class PrepareView: NSView {
    
    @IBOutlet weak var imageView: NSImageView!
    
    @IBOutlet weak var identiflerLabel: NSTextField!
    
    @IBOutlet weak var nameLabel: NSTextField!
    
    @IBOutlet weak var versionLabel: NSTextField!
    
    @IBOutlet weak var dateLabel: NSTextField!
    
    @IBOutlet weak var downlinkLabel: NSTextField!
    
    @IBOutlet weak var updateDescTextView: NSTextView!
    
    @IBOutlet weak var progressView: NSProgressIndicator!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
