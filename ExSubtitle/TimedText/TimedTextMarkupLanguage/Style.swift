
import Foundation

/*
 <style
    condition = <condition>
    style = IDREFS
    xml:base = <uri>
    xml:id = ID
    xml:lang = xsd:string
    xml:space = ("default" | "preserve")
    {any attributes in TT Style Namespaces}
    Content: Metadata.class*
</style>
 */
class Style: XML {
    var style: String?

    var stylingAttributes: [StylingAttribute : String] = [:]
    // Metadata.class

    override func parse(_ attributes: [String : String], namespaces: [String : String], parent: XML?) {
        super.parse(attributes)

        self.style = Util.getAttribute(attributes, name: "style")

        self.stylingAttributes = StylingAttribute.getAttributes(attributes, namespaces: namespaces)
        // TODO: repalce style
    }
}
