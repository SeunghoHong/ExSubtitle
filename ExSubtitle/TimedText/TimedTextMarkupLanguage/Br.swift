
import Foundation

/*
 <br
    condition = <condition>
    style = IDREFS
    xml:base = <uri>
    xml:id = ID
    xml:lang = xsd:string
    xml:space = ("default" | "preserve")
    {any attributes in TT Metadata Namespace}
    {any attributes in TT Style Namespaces}
    Content: Metadata.class*, Animation.class*
 </br>
 */
class Br: XML {
    var style: String?

    var stylingAttributes: [StylingAttribute : String] = [:]

    // Metadata.class
    // Animation.class

    override func parse(_ attributes: [String : String], namespaces: [String : String], parent: XML?) {
        super.parse(attributes)

        self.style = Util.getAttribute(attributes, name: "style")

        self.stylingAttributes = StylingAttribute.getAttributes(attributes, namespaces: namespaces)
        // TODO: replace style
    }
}
