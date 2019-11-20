//
//  ViewController.swift
//  PgyerUpdate
//
//  Created by 方林威 on 2019/10/31.
//  Copyright © 2019 方林威. All rights reserved.
//

import Cocoa
import Kingfisher

class MainViewController: ViewController<MainView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        container.dragContainerView.delegate = self
    }
    
    @IBAction func qAction(_ sender: Any) {
        NSApp.terminate(nil)
    }
    
    static func instance() -> Self {
        return StoryBoard.main.instance()
    }
}

extension MainViewController: DragContainerDelegate {
    
    func draggingEntered() {
        
    }
    
    func draggingExit() {
        
    }
    
    func draggingFileAccept(_ file: FileInfo) {
        Analysis.look(with: file.path) { [weak self](result) in
            guard let self = self else { return }
            switch result {
            case .success(let info):
                DispatchQueue.main.async {
                    let controller = MainPrepareController.instance(
                        info.name,
                        bundleId: info.bundleId,
                        version: info.version,
                        bundleVersion: info.bundleVersion,
                        date: info.creationDate,
                        path: file.path
                    )
                    self.presentAsModalWindow(controller)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


