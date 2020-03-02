//
//  Wechat.swift
//  PgyerUpdate
//
//  Created by 方林威 on 2019/11/1.
//  Copyright © 2019 方林威. All rights reserved.
//

import Foundation

enum Robot {
    case wechat(Wechat)
    case feishu(Feishu)
    
    struct Wechat: Codable, Equatable {
        let key: String = "0a3fdd95-47cd-4dd2-9790-bc2f7efd2cb9"
        let isQR = true
        let mobile: [String] = ["15910717228", "15010463860", "15665018938"]
    }
    
    struct Feishu {
        let key: String = "0409914b708a4360b28f45e777a13469"
    }
}
