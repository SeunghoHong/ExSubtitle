
import Foundation
import AVFoundation

class ExSubtitleInternal : NSObject {

    var timedText: TimedText!
    var onCue: ((Cue) -> Void)!
    
    weak var player: AVPlayer!
    var observer: Any!

    init(player: AVPlayer) {
        super.init()

        self.player = player
        self.addTimeObserver()
    }

    deinit {
        self.removeTimeObserver()
    }
}

extension ExSubtitleInternal {
    
    func addTimeObserver() {
        self.observer = self.player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 10, timescale: 1000), queue: DispatchQueue(label: "com.hongs.subtitle")) {
            let _ = Float(CMTimeGetSeconds($0))
            if let timedText = self.timedText, let onCue = self.onCue {
                // MARK: use the 10 millisecond unit for key
                if let cue = timedText.cues[Int64(CMTimeGetSeconds($0) * 1000) / 10] {
                    onCue(cue)
                }
            }
        }
    }

    func removeTimeObserver() {
        self.player.removeTimeObserver(self.observer)
    }
}

extension ExSubtitleInternal {

    func parse(with source: Data, mimetype: ExSubtitle.MimeType) {
        DispatchQueue.global().async {
            self.timedText = mimetype.create()
            // TODO: check error and notify
            self.timedText.parse(source)
        }
    }
}
