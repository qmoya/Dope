//
//  Form.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Foundation
import Parsing

func isWhitespace(_ c: UTF8.CodeUnit) -> Bool {
    let scalar = UnicodeScalar(c)
    switch scalar {
    case " ", ",", "\n", "\r", "\t":
        return true
    default:
        return false
    }
}

public struct DopeWhitespace: Equatable {
    let string: String
}

struct DopeWhitespaceParser: ParserPrinter {
	var body: some ParserPrinter<Substring, DopeWhitespace> {
        Prefix { isWhitespace($0) }.map(.string).map(.memberwise(DopeWhitespace.init))
    }
}

struct FormParser: ParserPrinter {
	var body: some ParserPrinter<Substring, Form> {
		Parse {
			OneOf {
                LiteralParser()
                    .map(.case(Form.literal))

				VectorParser()
					.map(.case(Form.vector))

				ListParser()
					.map(.case(Form.list))
                
                DopeWhitespaceParser()
                    .map(.case(Form.whitespace))
			}
        }
	}
}
