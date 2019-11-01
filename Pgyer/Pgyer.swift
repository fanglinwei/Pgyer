//
//  Pgyer.swift
//  PgyerUpdate
//
//  Created by 方林威 on 2019/10/31.
//  Copyright © 2019 方林威. All rights reserved.
//

import Foundation

enum Pgyer {
    
    static var apiKey = "b7b9e51d9589c2e9c6002db2214111ee"
    
    static var userKey = "e8db90f09703e5a141046fe115d3dfe0"
    
    /// ipa状态
    enum State {
        /// 已存在文件
        case existed
        /// 上传中
        case uploading
        /// 准备
        case ready
    }
}

extension Pgyer {
    
    struct Upload {
        let installType: Int = 1    //应用安装方式，值为(1,2,3，4)。1：公开，2：密码安装，3：邀请安装，4：回答问题安装。默认为1公开
        let password: String = ""   //设置App安装密码，如果不想设置密码，请传空字符串，或不传。
        let description: String     //版本更新描述，请传空字符串，或不传。
        let file: URL
        
        /// 文档 https://www.pgyer.com/doc/view/api#uploadApp
    }
}
