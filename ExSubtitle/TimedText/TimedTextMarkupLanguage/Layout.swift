
import Foundation

/*
 <layout
    xml:base = <uri>
    xml:id = ID
    xml:lang = xsd:string
    xml:space = ("default" | "preserve")
    Content: Metadata.class*, region*
 </layout>
 */
class Layout: XML {
    var regions: [String : Region] = [:]
    // Metadata.class
    // region
}
