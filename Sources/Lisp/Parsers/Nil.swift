import Parsing

struct NilParser: ParserPrinter {
	var body: some ParserPrinter<Substring, Nil> {
		"nil".map(.case(Nil.nil))
	}
}
