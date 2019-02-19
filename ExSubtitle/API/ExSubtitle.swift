
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

    init(player: AVPlayer) {
        self.impl = ExSubtitleInternal(player: player)
    }

    deinit {}
}

public extension ExSubtitle {

    func prepare(with source: Data, mimetype: MimeType) {
        self.impl.prepare(with: source, mimetype: mimetype)
    }
}
