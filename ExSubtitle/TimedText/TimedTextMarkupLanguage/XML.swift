
import Foundation

class XML {
    var tag: String!

    var id: String?
    var lang: String?
    var space: String?

    var string: String = ""
    var attributes: [String : String] = [:]
    
    weak var parent: XML?
    var children: [XML] = []

    var namespace = (prefix: "xml", URI: "http://www.w3.org/XML/1998/namespace")
    
    func parse(_ attributes: [String : String], namespaces: [String : String] = ["xml" : "http://www.w3.org/XML/1998/namespace"], parent: XML? = nil) {
        self.id = Util.getAttribute(attributes, name: "id", prefixes: Array(namespaces.keys))
        self.lang = Util.getAttribute(attributes, name: "lang", prefixes: Array(namespaces.keys))
        self.space = Util.getAttribute(attributes, name: "space", prefixes: Array(namespaces.keys))
    }
}

extension XML {
    func test(_ tag: String) {
        self.tag = tag
    }
}
