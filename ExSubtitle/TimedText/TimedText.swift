
import Foundation

extension ExSubtitle.MimeType {

    func create() -> TimedText? {
        switch self {
//        case .smi: return SAMI()
        case .srt: return SubRip()
//        case .ass: return SubStationAlpha()
//        case .vtt: return WebVTT()
//        case .ttml: return TimedTextMarkupLanguage()
        default:
            return nil
        }
    }
}

protocol TimedText: class {
    //var cues: [Float : Cue] { get set }

    func parse(_ data: Data) -> Bool
}

