
import Foundation
import CoreMedia

class TimeExpression {
    /*
     clock-time
     : hours ":" minutes ":" seconds ( fraction | ":" frames ( "." sub-frames )? )?
     */
    static var CLOCK_TIME_PATTERN: String { get { return "^([0-9][0-9]+):([0-9][0-9]):([0-9][0-9])(?:(\\.[0-9]+)|:([0-9][0-9])(?:\\.([0-9]+))?)?$" } }
    /*
     offset-time
     : time-count fraction? metric
     */
    static var OFFSET_TIME_PATTERN: String { get { return "^([0-9]+(?:\\.[0-9]+)?)(h|m|s|ms|f|t)$" } }

    enum Matric: String {
        case h, m, s, ms, f, t

        init?(_ string: String) {
            if string.hasSuffix("ms") {
                self = .ms
                return
            }

            let index = string.index(string.endIndex, offsetBy: -1)
            let last = string[index...]
            switch last {
            case "h": self = .h
            case "m": self = .m
            case "s": self = .s
            case "f": self = .f
            case "t": self = .t
            default: return nil
            }
        }

        func getSec(_ timescale: TimeInterval = 1000) -> TimeInterval {
            switch self {
            case .h : return 60 * 60 * timescale
            case .m : return 60 * timescale
            case .s : return timescale
            case .ms: return 1000 / timescale
            case .f, .t : return 1 // TODO: check f, t
            }
        }
    }

    enum TimeExpressionType {
        case CLOCK_TIME, OFFSET_TIME

        init?(_ string: String) {
            if string.matched(pattern: CLOCK_TIME_PATTERN) {
                self = .CLOCK_TIME
            } else if string.matched(pattern: OFFSET_TIME_PATTERN) {
                self = .OFFSET_TIME
            } else {
                return nil
            }
        }

        func timeInterval(from string: String) -> TimeInterval {
            switch self {
            case .CLOCK_TIME:
                return clockTime(from: string)
            case .OFFSET_TIME:
                return offsetTime(from: string)
            }
        }

        private func clockTime(from string: String) -> TimeInterval {
            let formatter = DateFormatter()
            formatter.dateFormat = "hh:mm:ss.SSS"
            guard let date = formatter.date(from: string), let zero =  formatter.date(from: "00:00:00.000") else { return -1 }

            return date.timeIntervalSince1970 - zero.timeIntervalSince1970
        }
        
        private func offsetTime(from string: String) -> TimeInterval {
            guard let matric = Matric(string), let range = string.range(of: matric.rawValue) else { return -1 }
            let numeric = string[..<range.lowerBound]
            guard let interval = TimeInterval(numeric) else { return -1 }
            return interval * matric.getSec(1)
        }
    }

    func timeInterval(from string: String) -> TimeInterval {
        guard let timeExpressionType = TimeExpressionType(string) else { return -1 }
        return timeExpressionType.timeInterval(from: string)
    }

    func toCMTime(from string: String) -> CMTime {
        let interval = self.timeInterval(from: string)
        return CMTimeMakeWithSeconds(interval, preferredTimescale: 1000)
    }

    func toString(from interval: TimeInterval, type: TimeExpressionType) -> String {
        // TODO:
        return "not implemented yet"
    }
}
