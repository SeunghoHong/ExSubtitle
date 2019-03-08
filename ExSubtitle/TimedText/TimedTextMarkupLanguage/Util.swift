
import Foundation

class Util {
    
    static func getAttribute(_ attributes: [String : String], name: String, prefixes: [String]? = nil) -> String? {
        guard let prefixes = prefixes else { return attributes[name] }
        for key in attributes.keys {
            for prefix in prefixes {
                if let range = key.range(of: "\(prefix):") {
                    let subKey = key[range.upperBound...]
                    if subKey == name {
                        return attributes[key]
                    }
                }
            }
        }
        return nil
    }
}
