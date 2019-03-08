
import Foundation

public struct Cue {
    public var start: Float64 // TODO: replace to Float
    public var end: Float64
    
    public class Setting {
        public class Style: Codable {
            var origin: String?
            var extent: String?
            var displayAlign: String?
            var backgroundColor: String?
            var fontStyle: String?
            var fontSize: String?
            var fontFamily: String?
            var fontWeight: String?
            var color: String?
            var textDecoration: String?
            var textAlign: String?
            var zIndex: String?
            var opacity: String?
            var border: String?
            var ruby: String?
        }
        
        public var region = Style()
        public var style = Style()
    }

    public typealias Payload = (setting: String, text: String)
    public var payloads: [Payload]

    public typealias Payload2 = (setting: Setting, text: String)
    public var payloads2: [Payload2]

    init(start: Float64, end: Float64) {
        self.start = start
        self.end = end
        self.payloads = []

        self.payloads2 = []
    }
}


extension Cue.Setting.Style {

    func apply(with attributes: [StylingAttribute : String]) {
        for attribute in attributes {
            switch attribute.key {
            case .origin: self.origin = attribute.value
            case .extent: self.extent = attribute.value
            case .displayAlign: self.displayAlign = attribute.value
            case .backgroundColor: self.backgroundColor = attribute.value
            case .fontStyle: self.fontStyle = attribute.value
            case .fontSize: self.fontSize = attribute.value
            case .fontFamily: self.fontFamily = attribute.value
            case .fontWeight: self.fontWeight = attribute.value
            case .color: self.color = attribute.value
            case .textDecoration: self.textDecoration = attribute.value
            case .textAlign: self.textAlign = attribute.value
            case .zIndex: self.zIndex = attribute.value
            case .opacity: self.opacity = attribute.value
            case .border: self.border = attribute.value
            case .ruby: self.ruby = attribute.value
            }
        }
    }

    func toString() -> String {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(self)
        return String(data: jsonData, encoding: .utf8) ?? ""
    }
}

// TODO: temporary
public extension Cue.Setting {

    func toString() -> String {
        return
"""
Region
\(self.region.toString())
Style
\(self.style.toString())
"""
    }
}
