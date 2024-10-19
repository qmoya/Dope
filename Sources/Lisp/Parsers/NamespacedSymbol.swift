//
//  Name.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct NamespacedSymbolParser: ParserPrinter {
	var body: some ParserPrinter<Substring, NamespacedSymbol> {
		Parse {
			NameParser()

			"/"

			SimpleSymbolParser()
		}
		.map(.memberwise(NamespacedSymbol.init))
	}
}
