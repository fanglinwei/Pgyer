//
//  File.swift
//  PgyerUpdate
//
//  Created by 方林威 on 2019/11/1.
//  Copyright © 2019 方林威. All rights reserved.
//

import Foundation
import CommonCrypto
import Kingfisher

extension Data {
    
  var md5: String {
      var digest = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
      
      _ = self.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) in
          return CC_MD5(bytes.baseAddress, CC_LONG(self.count), &digest)
      }
      
      return digest.map { String(format: "%02x", $0) }.joined()
  }
}

extension String: Resource {
    
    public var cacheKey: String { return self }
    public var downloadURL: URL { return URL(string: self) ?? URL(string: "https://www.abc.com")! }
}
