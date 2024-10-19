import Parsing

struct BooleanParser: ParserPrinter {
	var body: some ParserPrinter<Substring, Boolean> {
		Bool.parser().map(.memberwise(Boolean.init))
	}
}
