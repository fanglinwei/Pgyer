import Foundation
import Moya

public enum API {}

extension API {
    
    /// 插件，根据环境使用不同的插件
    static let plugins: [PluginType] = {
        
        #if DEBUG
        return [
            APITimeoutPlugin(),
            NetworkLoggerPlugin(verbose: true)
        ]
        #else
        return [
            NetworkLoggerPlugin(verbose: false),
            APIUploadPlugin(),
            APITimeoutPlugin()
        ]
        #endif
    }()
}
