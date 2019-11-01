//
//  Wechat.swift
//  PgyerUpdate
//
//  Created by 方林威 on 2019/11/1.
//  Copyright © 2019 方林威. All rights reserved.
//

import Foundation

enum Wechat {
    
    static var robots: [Robot] = []
    
    struct Robot: Codable {
        var bundleId: String
        var key: String
        var isQR: Bool
        
        let mobile: [String] = ["15910717228", "15010463860"]
    }
    
    static func addRobot(default bundleId: String) {
        robots.removeAll { $0.bundleId == bundleId }
        robots.append(.init(bundleId: bundleId, key: "0a3fdd95-47cd-4dd2-9790-bc2f7efd2cb9", isQR: true))
    }
    
    static func addRobot(with robot: Robot) {
        robots.removeAll { $0.bundleId == robot.bundleId }
        robots.append(robot)
    }
}
