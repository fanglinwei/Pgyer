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
        
        enum Mode {
            case word
            case pro
            
            var key: String {
                switch self {
                case .word:     return "3eb6a8d8-217a-4a2a-820d-b9da0eb46941"
                case .pro:      return "0a3fdd95-47cd-4dd2-9790-bc2f7efd2cb9"
                }
            }
        }
    }
}
