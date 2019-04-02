
/*
 * https://www.w3.org/TR/2018/REC-ttml2-20181108/
 * application/ttml+xml
 * application/xml+ttml

<?xml version="1.0" encoding="utf-8"?>
<tt xmlns:ttm="http://www.w3.org/ns/ttml#metadata" xmlns:tts="http://www.w3.org/ns/ttml#styling">
	<head>
		<metadata>
			<title/>
			<language>en_US</language>
			<region>US</region>
			<guid/>
			<emailid>support@speechpad.com</emailid>
		</metadata>
		<styling>
			<style xml:id="defaultCaption" tts:fontSize="10" tts:fontFamily="SansSerif"
			tts:fontWeight="normal" tts:fontStyle="normal"
			tts:textDecoration="none" tts:color="white"
			tts:backgroundColor="black" />
		</styling>
	</head>
	<body style="s0">
		<div>
			<p begin="00:00:03.400" end="00:00:06.177">In this lesson, we're going to<br />be talking about finance. And</p>
			<p begin="00:00:06.177" end="00:00:10.009">one of the most important aspects<br />of finance is interest.</p>
			<p begin="00:00:10.009" end="00:00:13.655">When I go to a bank or some<br />other lending institution</p>
			<p begin="00:00:13.655" end="00:00:17.720">to borrow money, the bank is happy<br />to give me that money. But then I'm</p>
			<p begin="00:00:17.900" end="00:00:21.480">going to be paying the bank for the<br />privilege of using their money. And that</p>
		</div>
	</body>
</tt>

 */

import Foundation

class TTML: NSObject {
    var cues: [Cue] = []

    var root = XML()
    var xml: XML!
    var parent: XML!

    var head: XML!
    var body: XML!

    var namespaces = ["xml" : "http://www.w3.org/XML/1998/namespace"]
}

extension TTML: TimedText {

    func parse(_ data: Data, completion: @escaping (Bool, Error?) -> Void) {
        let parser = XMLParser(data: data)
        parser.shouldProcessNamespaces = true
        parser.shouldReportNamespacePrefixes = true
        parser.delegate = self
        self.parent = self.root
        if parser.parse() == false {
            print("\(parser.parserError?.localizedDescription as Optional)")
            completion(false, parser.parserError)
            return
        }

        self.search(self.body, appliance: self.applyToCues(_:))
        completion(true, nil)
    }
}

extension TTML {

    func search(_ xml: XML, appliance: ((XML) -> Bool)? = nil) {
        if let appliance = appliance { if appliance(xml) == false { return /* MARK: break */ } }
        for child in xml.children {
            search(child, appliance: appliance)
        }
    }

    func find(_ xml: XML, id: String) -> XML? {
        var found: XML?
        self.search(xml) {
            if ($0.id == id) {
                found = $0
                return false
            }
            return true
        }
        return found
    }
}

extension TTML {

    func applyToCues(_ xml: XML) -> Bool {
        if let p = xml as? P {
            self.applyToCue(p)
        }
        return true
    }

    func applyToCue(_ xml: FullXML) {
        if xml.string.isEmpty {
            for child in xml.children where child is FullXML {
                applyToCue(child as! FullXML)
            }
        } else {
            guard let start = xml.timingAttributes[.begin], let end = xml.timingAttributes[.end] else { return }
            let timeExpression = TimeExpression()
            var cue = Cue(start: timeExpression.toCMTime(from: start), end: timeExpression.toCMTime(from: end), payloads: [])
            var styles: Cue.Styles

            if let id = xml.region {
                styles.region = Cue.Style(with: self.applyToRegion(with: id))
            }

            if let id = xml.style {
                styles.style = Cue.Style(with: self.applyToStyle(with: id))
            } else {
                styles.style = Cue.Style(with: [:])
            }

            if let style = styles.style {
                style += Cue.Style(with: xml.stylingAttributes)
            }

            cue.payloads.append((xml.string, "", styles))
            self.cues.append(cue)
        }
    }

    func applyToRegion(with id: String?) -> [StylingAttribute : String] {
        guard let id = id, let region = self.find(self.head, id: id) as? Region else { return [:] }
        region.stylingAttributes += self.applyToStyle(with: region.style)
        region.children.forEach {
            if let child = $0 as? Style {
                region.stylingAttributes += child.stylingAttributes
            }
        }

        return region.stylingAttributes
    }

    func applyToStyle(with id: String?) -> [StylingAttribute : String] {
        guard let id = id, let style = self.find(self.head, id: id) as? Style else { return [:] }
        style.stylingAttributes += self.applyToStyle(with: style.style)
        style.children.forEach {
            if let child = $0 as? Style {
                style.stylingAttributes += child.stylingAttributes
            }
        }

//        return style.stylingAttributes.reduce(attributes) { var r = $0; r[$1.0] = $1.1; return r }
        return style.stylingAttributes
    }
}

extension TTML: XMLParserDelegate {

    func parserDidStartDocument(_ parser: XMLParser) {
        print("\(#function)")
    }

    func parserDidEndDocument(_ parser: XMLParser) {
        print("\(#function)")
    }

    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]) {
        print("\(#function)")
        print("\(elementName)")
        print("\(namespaceURI as Optional)")
        print("\(qName as Optional)")
        print("\(attributeDict)")

        self.parent = self.xml ?? self.root
        self.xml = TAG.init(elementName).create()
        self.xml.test(elementName) // TODO: remove
        self.xml.parse(attributeDict, namespaces: self.namespaces, parent: self.parent)
        self.xml.parent = self.parent
        self.parent.children.append(self.xml)

        if elementName == "head" {
            self.head = self.xml
        } else if elementName == "body" {
            self.body = self.xml
        }
    }

    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?) {
        print("\(#function)")
        print("\(elementName)")
        print("\(namespaceURI as Optional)")
        print("\(qName as Optional)")

        self.xml = self.xml.parent
    }

    func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
        print("\(#function)")
        print("\(String(data: CDATABlock, encoding: .utf8) as Optional)")
    }

    func parser(_ parser: XMLParser, foundCharacters string: String) {
        print("\(#function)")
        print("\(string)")
        let string = string.trimmingCharacters(in: .whitespacesAndNewlines)
        if string.isEmpty == false {
            self.xml.string += string.trimmingCharacters(in: .whitespacesAndNewlines)
        }
    }

    func parser(_ parser: XMLParser, didStartMappingPrefix prefix: String, toURI namespaceURI: String) {
        print("\(#function)")
        print("\(prefix)")
        print("\(namespaceURI as Optional)")

        self.namespaces[prefix] = namespaceURI
    }

    func parser(_ parser: XMLParser, didEndMappingPrefix prefix: String) {
        print("\(#function)")
        print("\(prefix)")

        self.namespaces.removeValue(forKey: prefix)
    }
}

