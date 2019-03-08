
import Foundation

/*
 Styling Attributes
    tts:backgroundClip, tts:backgroundColor, tts:backgroundExtent, tts:backgroundImage,
    tts:backgroundOrigin, tts:backgroundPosition, tts:backgroundRepeat, tts:border, tts:bpd,
    tts:color, tts:direction, tts:disparity, tts:display, tts:displayAlign, tts:extent,
    tts:fontFamily, tts:fontKerning, tts:fontSelectionStrategy, tts:fontShear, tts:fontSize,
    tts:fontStyle, tts:fontVariant, tts:fontWeight, tts:ipd, tts:letterSpacing, tts:lineHeight,
    tts:lineShear, tts:luminanceGain, tts:opacity, tts:origin, tts:overflow, tts:padding,
    tts:position, tts:ruby, tts:rubyAlign, tts:rubyPosition, tts:rubyReserve, tts:shear,
    tts:showBackground, tts:textAlign, tts:textCombine, tts:textDecoration, tts:textEmphasis,
    tts:textOrientation, tts:textOutline, tts:textShadow, tts:unicodeBidi, tts:visibility,
    tts:wrapOption, tts:writingMode, tts:zIndex
 */
enum StylingAttribute: String, CaseIterable {
    case origin
    case extent
    case displayAlign, backgroundColor
    case fontStyle, fontSize
    case fontFamily, fontWeight
    case color
    case textDecoration, textAlign
    case zIndex, opacity
    case border, ruby
}

extension StylingAttribute {
    static func getAttributes(_ attributes: [String : String], namespaces: [String : String]) -> [StylingAttribute : String] {
        var stylingAttributes: [StylingAttribute : String] = [:]
        for timingAttribute in StylingAttribute.allCases {
            if let attribute = Util.getAttribute(attributes, name: timingAttribute.rawValue, prefixes: Array(namespaces.keys)) {
                stylingAttributes[timingAttribute] = attribute
            }
        }
        return stylingAttributes
    }
}
