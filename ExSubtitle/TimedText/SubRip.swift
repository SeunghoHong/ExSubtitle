
/*
 * https://en.wikipedia.org/wiki/SubRip 
 * application/x-subrip

 1
 00:00:13,800 --> 00:00:16,150
 No, that's not how it is.

 2
 00:00:16,150 --> 00:00:17,380
 I didn't mean that.

 */

import Foundation

class SubRip: TimedText {

    func parse(_ data: Data) -> Bool {
        return false
    }
}
