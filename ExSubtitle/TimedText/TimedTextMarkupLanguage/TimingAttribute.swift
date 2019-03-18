
import Foundation

/*
 Timing Attributes
    begin, dur, end, timeContainer
 */
enum TimingAttribute: String, CaseIterable {
    case begin, dur, end, timeContainer
}

extension TimingAttribute {
    static func getAttributes(_ attributes: [String : String], namespaces: [String : String]) -> [TimingAttribute : String] {
        var timingAttributes: [TimingAttribute : String] = [:]
        for timingAttribute in TimingAttribute.allCases {
            if let attribute = Util.getAttribute(attributes, name: timingAttribute.rawValue) {
                timingAttributes[timingAttribute] = attribute
            }
        }
        return timingAttributes
    }
}
