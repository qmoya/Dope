//
//  Number.swift
//  Dope
//
//  Created by Quico Moya on 18/10/24.
//
import Parsing

struct NumberParser: ParserPrinter {
	var body: some ParserPrinter<Substring, Number> {
		Int.parser()
			.map(.case(Number.integer))
	}
}
