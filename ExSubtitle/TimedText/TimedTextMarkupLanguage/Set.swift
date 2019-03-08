
import Foundation

/*
 <set
    begin = <time-expression>
    condition = <condition>
    dur = <time-expression>
    end = <time-expression>
    fill = <fill>
    repeatCount = <repeat-count>
    xml:base = <uri>
    xml:id = ID
    xml:lang = xsd:string
    xml:space = ("default" | "preserve")
    {any attributes in TT Style Namespaces}
    Content: Metadata.class*
 </set>
 */
class Set: XML {

    var timingAttributes: [TimingAttribute : String] = [:]
    var stylingAttributes: [StylingAttribute : String] = [:]
    // Metadat.class
    // Animation.class
    // Inline.class | Embedded.class

    override func parse(_ attributes: [String : String], namespaces: [String : String], parent: XML?) {
        super.parse(attributes)
        
        self.timingAttributes = TimingAttribute.getAttributes(attributes, namespaces: namespaces)
        self.stylingAttributes = StylingAttribute.getAttributes(attributes, namespaces: namespaces)
    }
}
