
import Foundation

extension Cue {

    init(startInterval: TimeInterval, endInterval: TimeInterval) {
        self.startMs = Int64(startInterval * 1000)
        self.endMs = Int64(endInterval * 1000)
        self.payloads = []
    }

    static func merge(from cues: [Cue], standardMs: Int64) -> Cue? {
        if cues.count == 0 { return nil }
        // MARK: use the 10 millisecond unit for key
        let timescale: Int64 = 10
        let standard = standardMs / timescale
        var matched = false

        var cue = Cue(startMs: cues[0].startMs, endMs: cues[0].endMs, payloads: [])
        cues.forEach {
            let start = $0.startMs / timescale
            let end = $0.endMs / timescale
            if start == standard || end == standard { matched = true }
            if end != standard {
                cue.payloads.append(contentsOf: $0.payloads)
            }
        }

        return matched ? cue : nil
    }
}

extension Cue.Style {

    convenience init(with attributes: [StylingAttribute : String]) {
        self.init()
        self.apply(with: attributes)
    }

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
            case .padding: self.padding = attribute.value
            case .textDecoration: self.textDecoration = attribute.value
            case .textAlign: self.textAlign = attribute.value
            case .zIndex: self.zIndex = attribute.value
            case .opacity: self.opacity = attribute.value
            case .border: self.border = attribute.value
            case .ruby: self.ruby = attribute.value
            case .textOutline: self.textOutline = attribute.value
            case .lineHight: self.lineHeight = attribute.value
            }
        }
    }
}
