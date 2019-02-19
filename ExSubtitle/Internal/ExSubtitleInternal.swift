
import Foundation
import AVFoundation

class ExSubtitleInternal : NSObject {

    var timedText: TimedText!
    
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
        self.observer = self.player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 33, timescale: 1000), queue: DispatchQueue(label: "com.hongs.subtitle")) {
            let _ = Float(CMTimeGetSeconds($0))
        }
    }

    func removeTimeObserver() {
        self.player.removeTimeObserver(self.observer)
    }
}

extension ExSubtitleInternal {

    func prepare(with source: Data, mimetype: ExSubtitle.MimeType) {
        DispatchQueue.global().async {
            self.timedText = mimetype.create()
            // TODO: check error and notify
            self.timedText.parse(source)
        }
    }
}
