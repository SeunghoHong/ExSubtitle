
import Foundation

extension Dictionary {

    static func += (lhs: inout [Key : Value], rhs: [Key : Value]) {
        rhs.forEach {
            lhs[$0.key] = $0.value
        }
    }
}
