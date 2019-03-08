
import Foundation
enum TAG: String, CaseIterable {
    // MARK: content element
    case tt, head, body, div, p, span, br
    // MARK: embedded content element
    case audio, chunk, data, font, image, resources, source
    // MARK: styling element
    case initial, style, styling
    // MARK: layout element
    case layout, region
    // MARK: animation element
    case animate, animation, set
    // MARK: metadata element
    case metadata
    case unknown

    static func contains(_ element: String) -> Bool {
        return TAG.allCases.map {
            $0.rawValue
        }.contains(element)
    }

    init(_ element: String) {
        self = TAG.init(rawValue: element) ?? .unknown
    }

    func create() -> XML {
        print("tag : \(self.rawValue)")
        switch self {
        case .tt: return XML()
        case .head: return Head()
        case .body: return Body()
        case .div: return Div()
        case .p: return P()
        case .span: return Span()
        case .br: return Br()

        case .audio, .chunk, .data, .font, .image, .resources, .source: return XML()

        case .initial: return XML()
        case .style: return Style()
        case .styling: return Styling()

        case .layout: return Layout()
        case .region: return Region()

        case .animate, .animation: return XML()
        case .set: return Set()

        case .metadata: return XML()
        default: return XML()
        }
    }
}
