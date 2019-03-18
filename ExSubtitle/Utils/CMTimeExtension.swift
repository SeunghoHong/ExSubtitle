
import CoreMedia

extension CMTime {

    static func == (time1: CMTime, time2: CMTime) -> Bool {
        // MARK: use the 10 millisecond unit for key
        return time1.value(with: 100) == time2.value(with: 100)
    }

    static func != (time1: CMTime, time2: CMTime) -> Bool {
        // MARK: use the 10 millisecond unit for key
        return time1.value(with: 100) != time2.value(with: 100)
    }

    static func <= (time1: CMTime, time2: CMTime) -> Bool {
        // MARK: use the 10 millisecond unit for key
        return time1.value(with: 100) <= time2.value(with: 100)
    }

    func value(with timescale: CMTimeScale) -> CMTimeValue {
        return CMTimeMakeWithSeconds(CMTimeGetSeconds(self), preferredTimescale: timescale).value
    }
}
