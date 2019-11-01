//
//  Analysis.swift
//  PgyerUpdate
//
//  Created by 方林威 on 2019/11/1.
//  Copyright © 2019 方林威. All rights reserved.
//  ipa解析类

import Cocoa

// "ipa"解压器
class Analysis {
    
    private struct File {
        var working: URL { URL(fileURLWithPath: NSTemporaryDirectory().appendingPathComponent("org.calm.ipainfo")) }
        
        var payload: URL { working.appendingPathComponent("Payload") }
        
        private(set) var infoPlist: URL?
        
        private(set) var app: URL?
        
        private(set) var icon: URL?
        
        mutating func findPlist( _ completion: @escaping (Result<Void, Error>) -> Void) {
            guard let contents = try? FileManager.default.contentsOfDirectory(at: payload, includingPropertiesForKeys:nil) else {
                completion(.failure(.payload))
                return
            }
            // 查找app
            guard let appPath = contents.first(where: {$0.pathExtension.lowercased() == "app"}) else {
                completion(.failure(.app))
                return
            }
            app = appPath
            infoPlist = appPath.appendingPathComponent("Info.plist")
            icon = appPath.appendingPathComponent("AppIcon60x60@2x.png")
        }
    }
    
    // 解压工作路径
    private static var file = File()
    
    static func look(with pack: URL, _ completion: @escaping (Result<Info, Error>) -> Void) {
        guard pack.pathExtension.lowercased() == "ipa" else {
            completion(.failure(.ipa))
            return
        }
        
        try? FileManager.default.removeItem(at: file.working)
        do {
            let bin = URL(fileURLWithPath: "/usr/bin/unzip")
            try Process.run(bin, arguments: ["-q", pack.path, "-d", file.working.path]) { process in
                process.waitUntilExit()
                findInfo(completion)
            }
        } catch {
            completion(.failure(.decompression))
        }
    }
    
    private static func findInfo(_ completion: @escaping (Result<Info, Error>) -> Void) {
        guard FileManager.default.fileExists(atPath: file.payload.path) else {
            completion(.failure(.payload))
            return
        }
        file.findPlist { (result) in
            result.error.map { completion(.failure($0)) }
        }
    
        do {
            guard let plist = file.infoPlist else {
                completion(.failure(.payload))
                return
            }
            let data = try Data(contentsOf: plist)
            let infoPlist = try PropertyListDecoder().decode(InfoPlist.self, from: data)
            
            let attributes: [FileAttributeKey : Any] = try FileManager.default.attributesOfItem(atPath: plist.path)
            var info = Info(infoPlist)
            
            if let date = attributes[.creationDate] as? Date {
                info.creationDate = date
            }
            
            if let path = file.icon, let icon = NSImage(contentsOf: path) {
                info.icon = icon
            }
            
            completion(.success(info))
            
        } catch {
            completion(.failure(.info))
        }
    }
}

extension Analysis {
    
    struct Info {
        let name: String
        let bundleName: String
        let bundleId: String
        let version: String
        let bundleVersion: String
        var creationDate: Date?
        var icon: NSImage?
        
        fileprivate init(_ infoPlist: InfoPlist) {
            self.name = infoPlist.name
            self.bundleName = infoPlist.bundleName
            self.bundleId = infoPlist.bundleId
            self.version = infoPlist.version
            self.bundleVersion = infoPlist.bundleVersion
        }
    }
    
    fileprivate struct InfoPlist: Codable {
        let name: String
        let bundleName: String
        let bundleId: String
        let version: String
        let bundleVersion: String
        
        enum CodingKeys: String, CodingKey {
            case name = "CFBundleDisplayName"
            case bundleName = "CFBundleName"
            case bundleId = "CFBundleIdentifier"
            case version = "CFBundleShortVersionString"
            case bundleVersion = "CFBundleVersion"
        }
    }
    
    enum Error: Swift.Error, LocalizedError {
        case ipa
        case decompression
        case info
        case payload
        case app
        case infoPlist
        
        var errorDescription: String? {
            switch self {
            case .ipa:                  return "不是ipa文件"
            case .decompression:        return "解压失败"
            case .info:                 return "infoPlist解析失败"
            case .payload:              return "未找到payload"
            case .app:                  return "未找到app"
            case .infoPlist:            return "未找到infoPlist"
            }
        }
    }
}


extension String {
    
    func appendingPathComponent(_ string: String) -> String {
        guard let url = URL(string: self) else {
            return self
        }
        return url.appendingPathComponent(string).absoluteString
    }
}
