//
//  Wechat.swift
//  PgyerUpdate
//
//  Created by 方林威 on 2019/11/1.
//  Copyright © 2019 方林威. All rights reserved.
//

import Foundation

enum Wechat {
    
    struct Robot: Codable, Equatable {
        var key: String
        var isQR: Bool
        let mobile: [String] = ["15910717228", "15010463860", "15665018938"]
    }
}
