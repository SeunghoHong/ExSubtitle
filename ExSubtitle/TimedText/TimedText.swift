
import Foundation

extension ExSubtitle.MimeType {

    func create() -> TimedText? {
        switch self {
//        case .smi: return SAMI()
        case .srt: return SRT()
//        case .ass: return ASS()
//        case .vtt: return WebVTT()
        case .ttml: return TTML()
        default:
            return nil
        }
    }
}

protocol TimedText: class {
    var cues: [Cue] { get set }

    func parse(_ data: Data, completionHandler: @escaping () -> Void, errorHandler: @escaping (Error?) -> Void)
}

