
import Foundation
import AVFoundation

class ExSubtitleInternal : NSObject {

    var timedText: TimedText!
    var onCue: ((Cue) -> Void)!
    var force = true
    
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
        // TODO: re-calculate interval
        self.observer = self.player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 5, timescale: 1000), queue: DispatchQueue(label: "com.hongs.subtitle")) {
            let current = $0
            if let timedText = self.timedText, let onCue = self.onCue {
                // MARK: gather all cues between start and end
                let cues = timedText.cues.filter {
                    $0.start <= current && current <= $0.end
                }

                if let cue = Cue.merge(from: cues, current: current, force: self.force) {
                    print("\(CMTimeGetSeconds(current)) - \(cue.payloads.count)")
                    onCue(cue)
                    self.force = false
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
            self.timedText.parse(source) {
                guard $0 == true else { return }
                if let error = $1 {
                    print("E: \(error.localizedDescription)")
                }
            }
        }
    }
}
