
import Foundation

/*
 <span
    animate = IDREFS
    begin = <time-expression>
    condition = <condition>
    dur = <time-expression>
    end = <time-expression>
    region = IDREF
    style = IDREFS
    timeContainer = ("par" | "seq")
    xlink:arcrole = <uri-list>
    xlink:href = <uri>
    xlink:role = <uri-list>
    xlink:show = ("new" | "replace" | "embed" | "other" | "none") : new
    xlink:title = xsd:string
    xml:base = <uri>
    xml:id = ID
    xml:lang = xsd:string
    xml:space = ("default" | "preserve")
    {any attributes in TT Metadata Namespace}
    {any attributes in TT Style Namespaces}
    Content: Metadata.class*, Animation.class*, (Inline.class|Embedded.class)*
 </span>
 */
class Span: FullXML {
    // Metadat.class
    // Animation.class
    // Inline.class | Embedded.class
}
