import Parsing

struct SymbolParser: Parser {
    var body: some Parser<Substring, Symbol> {
        OneOf {
            NamespacedSymbolParser().map(Symbol.namespaced)
            SimpleSymbolParser().map(Symbol.simple)
        }
    }
}
