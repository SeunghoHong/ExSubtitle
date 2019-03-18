
import Foundation

/*
 <region
    animate = IDREFS
    begin = <time-expression>
    condition = <condition>
    dur = <time-expression>
    end = <time-expression>
    style = IDREFS
    timeContainer = ("par" | "seq")
    ttm:role = xsd:string
    xml:base = <uri>
    xml:id = ID
    xml:lang = xsd:string
    xml:space = ("default" | "preserve")
    {any attributes in TT Style Namespaces}
    Content: Metadata.class*, Animation.class*, style*
 </region>
 */

class Region: XML {
    var style: String?

    var timingAttributes: [TimingAttribute : String] = [:]
    var stylingAttributes: [StylingAttribute : String] = [:]

    // Metadata.class
    // Animation.class
    // style

    override func parse(_ attributes: [String : String], namespaces: [String : String], parent: XML?) {
        super.parse(attributes)
        
        self.style = Util.getAttribute(attributes, name: "style")
        
        self.timingAttributes = TimingAttribute.getAttributes(attributes, namespaces: namespaces)
        self.stylingAttributes = StylingAttribute.getAttributes(attributes, namespaces: namespaces)
        // TODO: replace style
    }
}
