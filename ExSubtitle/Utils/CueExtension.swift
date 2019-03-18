
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
        for (key, value) in attributes {
            switch key {
            case .origin: self.origin = value
            case .extent: self.extent = value
            case .displayAlign: self.displayAlign = value
            case .backgroundColor: self.backgroundColor = value
            case .fontStyle: self.fontStyle = value
            case .fontSize: self.fontSize = value
            case .fontFamily: self.fontFamily = value
            case .fontWeight: self.fontWeight = value
            case .color: self.color = value
            case .padding: self.padding = value
            case .textDecoration: self.textDecoration = value
            case .textAlign: self.textAlign = value
            case .zIndex: self.zIndex = value
            case .opacity: self.opacity = value
            case .border: self.border = value
            case .ruby: self.ruby = value
            case .textOutline: self.textOutline = value
            case .lineHight: self.lineHeight = value
            }
        }
    }
}
