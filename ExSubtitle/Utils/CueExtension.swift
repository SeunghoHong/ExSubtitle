
import Foundation
import CoreMedia

extension Cue {

    static func merge(from cues: [Cue], current: CMTime) -> Cue? {
        if cues.count == 0 { return nil }
        var matched = false

        var cue = Cue(start: cues[0].start, end: cues[0].end, payloads: [])
        cues.forEach {
            if $0.start == current || $0.end == current { matched = true }
            if $0.end != current {
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
