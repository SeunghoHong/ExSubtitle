
import Foundation

/*
 <head
    xml:base = <uri>
    xml:id = ID
    xml:lang = xsd:string
    xml:space = ("default" | "preserve")
    Content: Metadata.class*, Profile.class*, resources?, styling?, layout?, animation?
 </head>
 */
class Head: XML {
    var styling: Styling?
    var layout: Layout?
    // Metadata.class
    // Profile.class
    // resources
    // styling
    // layout
    // animation
}
