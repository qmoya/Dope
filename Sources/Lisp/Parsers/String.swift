import Parsing

struct StringParser: ParserPrinter {
	var body: some ParserPrinter<Substring, String> {
		Parse {
			"\""
			Prefix { $0 != "\"" }
			"\""
		}.map(.string)
	}
}
