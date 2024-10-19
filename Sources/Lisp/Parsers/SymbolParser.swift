import Parsing

struct SymbolParser: ParserPrinter {
	var body: some ParserPrinter<Substring, Symbol> {
		OneOf {
			NamespacedSymbolParser().map(.case(Symbol.namespaced))
			SimpleSymbolParser().map(.case(Symbol.simple))
		}
	}
}
