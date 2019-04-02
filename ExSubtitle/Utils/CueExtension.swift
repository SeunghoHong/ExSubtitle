
import Foundation
import CoreMedia

extension Cue {

    static func merge(from cues: [Cue], current: CMTime, force: Bool = false) -> Cue? {
        if cues.count == 0 { return nil }
        var matched = false

        var cue = Cue(start: cues[0].start, end: cues[0].end, payloads: [])
        cues.forEach {
            if $0.start == current || $0.end == current { matched = true }
            if $0.end != current {
                cue.payloads.append(contentsOf: $0.payloads)
            }
        }

        return (matched || force) ? cue : nil
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

    static func += (lhs: Cue.Style, rhs: Cue.Style) {
        if let origin = rhs.origin { lhs.origin = origin }
        if let extent = rhs.extent { lhs.extent = extent }
        if let displayAlign = rhs.displayAlign { lhs.displayAlign = displayAlign }
        if let backgroundColor = rhs.backgroundColor { lhs.backgroundColor = backgroundColor }
        if let fontStyle = rhs.fontStyle { lhs.fontStyle = fontStyle }
        if let fontSize = rhs.fontSize { lhs.fontSize = fontSize }
        if let fontFamily = rhs.fontFamily { lhs.fontFamily = fontFamily }
        if let fontWeight = rhs.fontWeight { lhs.fontWeight = fontWeight }
        if let color = rhs.color { lhs.color = color }
        if let padding = rhs.padding { lhs.padding = padding }
        if let textDecoration = rhs.textDecoration { lhs.textDecoration = textDecoration }
        if let textAlign = rhs.textAlign { lhs.textAlign = textAlign }
        if let zIndex = rhs.zIndex { lhs.zIndex = zIndex }
        if let opacity = rhs.opacity { lhs.opacity = opacity }
        if let border = rhs.border { lhs.border = border }
        if let ruby = rhs.ruby { lhs.ruby = ruby }
        if let textOutline = rhs.textOutline { lhs.textOutline = textOutline }
        if let lineHeight = rhs.lineHeight { lhs.lineHeight = lineHeight }
    }
}
