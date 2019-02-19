
import Foundation

public struct Cue {
    var start: Int64 // TODO: replace to Float
    var end: Int64

    typealias Payload = (setting: String, text: String)
    var payloads: [Int64 : Payload]
}
