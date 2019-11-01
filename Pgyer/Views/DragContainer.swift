//
//  DragContainer.swift
//  tinypng
//
//  Created by kyle on 16/6/30.
//  Copyright © 2016年 kyleduo. All rights reserved.
//

import Cocoa

protocol DragContainerDelegate: NSObjectProtocol {
	func draggingEntered()
	func draggingExit()
	func draggingFileAccept(_ file: FileInfo)
}

class DragContainer: NSView {
    
	weak var delegate : DragContainerDelegate?
	
    var state: Pgyer.State = .ready
    
	override func awakeFromNib() {
		super.awakeFromNib()
		
        registerForDraggedTypes(
            [ .backwardsCompatibleFileURL,
              .init(rawValue: kUTTypeItem as String)
            ]
        )
	}
	
	override func draw(_ dirtyRect: NSRect) {
		
	}
	
	override func draggingEntered(_ sender: NSDraggingInfo) -> NSDragOperation {
        self.layer?.backgroundColor = NSColor(white: 1, alpha: 0.2).cgColor;
		delegate?.draggingEntered()
        return NSDragOperation.generic
	}
	
	override func draggingExited(_ sender: NSDraggingInfo?) {
        layer?.backgroundColor = NSColor(white: 1, alpha: 0).cgColor;
		delegate?.draggingExit();
	}
	
	override func prepareForDragOperation(_ sender: NSDraggingInfo) -> Bool {
        self.layer?.backgroundColor = NSColor(white: 1, alpha: 0).cgColor
		return true
	}
	
	override func performDragOperation(_ sender: NSDraggingInfo) -> Bool {
        guard
            let board = sender.draggingPasteboard.propertyList(forType: .init("NSFilenamesPboardType")) as? Array<String>,
            board.count == 1 else {
            return false
        }
        guard
            let frist = board.first,
            let file = collectFiles(frist)  else {
            return false
        }
		delegate?.draggingFileAccept(file)
		return true
	}
    
    func collectFiles(_ filePath: String) -> FileInfo? {
        guard fileIsAcceptable(filePath) else {
            return nil
        }
        let url = URL(fileURLWithPath: filePath)
        return FileInfo(path: url, relativePath: url.lastPathComponent)
    }
    
    func fileIsAcceptable(_ path: String) -> Bool {
        let url = URL(fileURLWithPath: path)
        let fileExtension = url.pathExtension.lowercased()
        let acceptable = ["ipa", "apk"]
        return acceptable.contains(fileExtension)
    }
}
