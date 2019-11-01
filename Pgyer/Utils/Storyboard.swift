import Foundation
import Cocoa

enum StoryBoard: String {
    case main             = "Main"
    
    var storyboard: NSStoryboard {
        return NSStoryboard(name: rawValue, bundle: nil)
    }
    
    func instance<T>() -> T {
        return storyboard.instantiateController(withIdentifier: String(describing: T.self)) as! T
    }
}
