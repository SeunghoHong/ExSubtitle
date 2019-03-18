
import Foundation

/*
 begin = <time-expression>
 dur = <time-expression>
 end = <time-expression>
 region = IDREF
 style = IDREFS
 {any attributes in TT Style Namespaces}
 */

class FullXML: XML {
    var region: String?
    var style: String?
    
    var timingAttributes: [TimingAttribute : String] = [:]
    var stylingAttributes: [StylingAttribute : String] = [:]

    override func parse(_ attributes: [String : String], namespaces: [String : String], parent: XML?) {
        super.parse(attributes)

        self.region = Util.getAttribute(attributes, name: "region")
        self.style = Util.getAttribute(attributes, name: "style")

        self.timingAttributes = TimingAttribute.getAttributes(attributes, namespaces: namespaces)
        self.stylingAttributes = StylingAttribute.getAttributes(attributes, namespaces: namespaces)

        // MARK: apply from parent
        do {
            guard let parent = parent as? FullXML else { return }
            if self.region == nil { self.region = parent.region }
            if self.style == nil { self.style = parent.style }
            
            parent.timingAttributes.forEach {
                if Array(self.timingAttributes.keys).contains($0.key) {
                    // MARK: skip
                } else {
                    self.timingAttributes[$0.key] = $0.value
                }
            }
            // TODO: check about stylingAttributes
        }
    }
}
