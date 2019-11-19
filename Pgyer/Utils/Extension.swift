//
//  File.swift
//  PgyerUpdate
//
//  Created by 方林威 on 2019/11/1.
//  Copyright © 2019 方林威. All rights reserved.
//

import Foundation
import Kingfisher

extension String: Resource {
    
    public var cacheKey: String { return self }
    public var downloadURL: URL { return URL(string: self) ?? URL(string: "https://www.abc.com")! }
}
