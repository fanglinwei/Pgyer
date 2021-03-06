//
//  APIPgyerTarget.swift
//  TODOIELTS
//
//  Created by 方林威 on 2019/10/15.
//

import Moya
import Alamofire

extension API {
    static let pgyer = MoyaProvider<APIPgyerTarget>(plugins: plugins)
}

enum APIPgyerTarget {
    /// 上传
    case upload(Pgyer.Upload)
    /// 上传预览
    case uploadPrepare(type: String, bundleId: String)
    /// 信息
    case info
    /// app列表
    case list
    
}

extension APIPgyerTarget: TargetType {
    
    var baseURL: URL { URL(string: "https://www.pgyer.com/apiv2")! }
    
    var path: String {
        switch self {
        case .upload:               return "app/upload"
        case .uploadPrepare:        return "app/uploadPrepare"
        case .info:                 return "app/view"
        case .list:                 return "app/listMy"
        }
    }
    
    var method: Moya.Method { .post }
    
    var task: Task {
        switch self {
        case let .upload(body):
            return .uploadMultipart([
                .init(provider: .file(body.file), name: "file"),
                .init(provider: .data(Pgyer.apiKey.data(using: .utf8)!), name: "_api_key"),
                .init(provider: .data(String(body.installType).data(using: .utf8)!), name: "buildInstallType"),
                .init(provider: .data(body.password.data(using: .utf8)!), name: "buildPassword"),
                .init(provider: .data(body.description.data(using: .utf8)!), name: "buildUpdateDescription")
            ])
            
        case let .uploadPrepare(type, bundleId):
            return .json(["_api_key": Pgyer.apiKey,
                          "userKey": Pgyer.userKey,
                          "packageName": bundleId,
                          "type": type]
            )
        case .list:
            return .json(["_api_key": Pgyer.apiKey])
        default:
            return .requestPlain
        }
    }
    
    var validationType: ValidationType {
        return .successAndRedirectCodes
    }
    
    var sampleData: Data {
         return Data()
    }
    
    var headers: [String: String]? {
        switch self {
        case .uploadPrepare:
            return ["Content-Type": "application/x-www-form-urlencoded; charset=utf-8"]
        default:
            return ["Content-Type": "application/x-www-form-urlencoded"]
        }
    }
}

extension Task {
    
    fileprivate static func json(_ parameters: [String: Any]) -> Task {
        return .requestParameters(
            parameters: parameters,
            encoding: URLEncoding.default
        )
    }
}
