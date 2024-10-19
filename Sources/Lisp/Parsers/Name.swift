//
//  Name.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

public struct Name: Equatable {
	struct HeadAndRest: Equatable {
		let head: String
		let rest: String
	}

	struct Tail: Equatable {
		let components: [String]
	}

	let headAndRest: HeadAndRest
	let tail: Tail?
}

struct NameParser: ParserPrinter {
	struct TailParser: ParserPrinter {
		var body: some ParserPrinter<Substring, Name.Tail> {
			Many {
				SymbolRestParser()
			} separator: {
				":"
			}
			.map(.memberwise(Name.Tail.init))
		}
	}

	var body: some ParserPrinter<Substring, Name> {
		Parse {
			Parse {
				SymbolHeadParser()
				SymbolRestParser()
			}
			.map(.memberwise(Name.HeadAndRest.init))

			Optionally {
				":"

				TailParser()
			}
		}
		.map(.memberwise(Name.init))
	}
}
