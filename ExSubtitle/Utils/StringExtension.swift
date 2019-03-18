
import Foundation

extension String {

    func matched(pattern: String) -> Bool {
        let regex = try! NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: self.count)) != nil
    }
}
