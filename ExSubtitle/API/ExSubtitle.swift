
import Foundation
import AVFoundation

public class ExSubtitle : NSObject {

    public enum MimeType {
        case smi, srt, ass, vtt, ttml
        
        init?(string: String) {
            switch string {
            case "application/smil+xml": self = .smi
            case "application/x-subrip": self = .srt
            case "application/x-ass": self = .ass
            case "text/vtt": self = .vtt
            case "application/xml+ttml", "application/ttml+xml": self = .ttml
            default: return nil
            }
        }
    }

    private var impl: ExSubtitleInternal!

    public init(player: AVPlayer) {
        self.impl = ExSubtitleInternal(player: player)
    }

    deinit {}
}

public extension ExSubtitle {

    func parse(from source: Data, mimetype: MimeType, completionHandler: @escaping () -> Void, errorHandler: @escaping (Error?) -> Void) {
        self.impl.parse(from: source, mimetype: mimetype, completionHandler: completionHandler, errorHandler: errorHandler)
    }
}

public extension ExSubtitle {

    func setOnCue(_ onCue: @escaping ((Cue) -> Void)) {
        self.impl.onCue = onCue
    }
}
