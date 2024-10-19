//
//  Name.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

func isSymbolHead(_ c: UTF8.CodeUnit) -> Bool {
	let scalar = UnicodeScalar(c)
	switch scalar {
	case " ",
	     ",", ":", "'", "(", ")", "[", "]", "{", "}", "@",
	     "/", "\"", "\n", "\r", "\t", "#",
	     "%", "`", "^", "~", "0" ... "9":
		return false
	default:
		return true
	}
}

struct SymbolHeadParser: ParserPrinter {
	var body: some ParserPrinter<Substring, Swift.String> {
		Prefix(1) { isSymbolHead($0) }.map(.string)
	}
}
