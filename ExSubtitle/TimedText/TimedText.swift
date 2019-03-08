
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
    // MARK: The time unit of key is millisecond
    // MARK: make 10 millisecond unit for notifying through AVPlayer.periodicTimeObserver
    var cues: [Int64 : Cue] { get set }

    func parse(_ data: Data) -> Bool
}

