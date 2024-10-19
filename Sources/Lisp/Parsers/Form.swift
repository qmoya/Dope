//
//  Form.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Foundation
import Parsing

public struct DopeWhitespace: Equatable {
	let string: Substring
}

struct DopeWhitespaceParser: ParserPrinter {
	var body: some ParserPrinter<Substring, DopeWhitespace> {
		CharacterSet.whitespacesAndNewlines
			.map(.memberwise(DopeWhitespace.init))
	}
}

struct FormParser: ParserPrinter {
	var body: some ParserPrinter<Substring, Form> {
		Parse {
			OneOf {
				VectorParser()
					.map(.case(Form.vector))

				LiteralParser()
					.map(.case(Form.literal))

				ListParser()
					.map(.case(Form.list))

				//                DopeWhitespaceParser()
				//                    .map(.case(Form.whitespace))
				//                CharacterSet.whitespacesAndNewlines.map(.case(Form.whitespace))
			}
			//            .replaceError(with: Form.whitespace(.init(string: "error")))
		}
	}
}
