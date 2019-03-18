
import Foundation

/*
 <styling
    xml:base = <uri>
    xml:id = ID
    xml:lang = xsd:string
    xml:space = ("default" | "preserve")
    Content: Metadata.class*, initial*, style*
 </styling>
 */
class Styling: XML {
    var styles: [String : Style] = [:]
    // Metadata.class
    // inital
    // style
}
