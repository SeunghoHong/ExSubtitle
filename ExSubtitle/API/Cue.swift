
import Foundation

public struct Cue {
    public var startMs: Int64 // TODO: replace to Float
    public var endMs: Int64

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
        var padding: String?
        var textDecoration: String?
        var textAlign: String?
        var zIndex: String?
        var opacity: String?
        var border: String?
        var ruby: String?
        var textOutline: String?
        var lineHeight: String?
    }

    public typealias Styles = (region: Style?, style: Style?)
    public typealias Payload = (text: String, setting: String?, styles: Styles?)
    public var payloads: [Payload]
}

public extension Cue.Style {

    func toString() -> String {
        let jsonEncoder = JSONEncoder()
        let jsonData = try! jsonEncoder.encode(self)
        return String(data: jsonData, encoding: .utf8) ?? ""
    }
}
